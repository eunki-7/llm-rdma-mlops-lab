import os, json, logging
from datasets import Dataset
from transformers import AutoTokenizer, AutoModelForCausalLM, TrainingArguments, Trainer, DataCollatorForLanguageModeling

model_name = os.environ.get("MODEL_NAME", "Qwen/Qwen2-7B")
data_path  = os.environ.get("DATA_PATH", "/data/jsonl")
out_dir    = os.environ.get("OUT_DIR", "/outputs/qwen2-7b-sft")
max_len    = int(os.environ.get("MAX_LEN", "2048"))

logging.basicConfig(level=logging.INFO)

def load_jsonl_dataset(path):
    rows = []
    for fn in os.listdir(path):
        if fn.endswith(".jsonl"):
            with open(os.path.join(path, fn), "r", encoding="utf-8") as f:
                for line in f:
                    rows.append(json.loads(line))
    return rows

def format_example(ex):
    return f"### Instruction:\n{ex['prompt']}\n\n### Response:\n{ex['response']}\n"

def main():
    tokenizer = AutoTokenizer.from_pretrained(model_name, use_fast=True)
    model = AutoModelForCausalLM.from_pretrained(model_name, torch_dtype="auto")

    raw = load_jsonl_dataset(data_path)
    texts = [format_example(r) for r in raw]
    dtrain = Dataset.from_dict({"text": texts})

    def tok(batch):
        return tokenizer(batch["text"], truncation=True, max_length=max_len)

    tokenized = dtrain.map(tok, batched=True, remove_columns=["text"])

    args = TrainingArguments(
        output_dir=out_dir,
        per_device_train_batch_size=1,
        gradient_accumulation_steps=16,
        num_train_epochs=1,
        learning_rate=2e-5,
        lr_scheduler_type="cosine",
        warmup_ratio=0.03,
        logging_steps=10,
        save_steps=500,
        save_total_limit=2,
        bf16=True,
        deepspeed="ds_zero2.json",
        report_to=[]
    )
    data_collator = DataCollatorForLanguageModeling(tokenizer, mlm=False)
    trainer = Trainer(model=model, args=args, train_dataset=tokenized, data_collator=data_collator)
    trainer.train()
    trainer.save_model(out_dir)

if __name__ == "__main__":
    main()
