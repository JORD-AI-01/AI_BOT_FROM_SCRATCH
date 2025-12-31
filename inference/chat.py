#Testing a chat model using Hugging Face Transformers
from transformers import AutoModelForCausalLM, AutoTokenizer
import torch

#
MODEL_NAME = "TinyLlama/TinyLlama-1.1B-Chat-v1.0"

tokenizer = AutoTokenizer.from_pretrained(MODEL_NAME)
model = AutoModelForCausalLM.from_pretrained(
    MODEL_NAME,
    torch_dtype=torch.float16,
    device_map="auto"
)
#
print("Chatbot ready. Type 'exit' to quit.")

while True:
    prompt = input("You: ")
    if prompt.lower() == "exit":
        break

    inputs = tokenizer(prompt, return_tensors="pt").to(model.device)

    outputs = model.generate(
        **inputs,
        max_new_tokens=200,
        do_sample=True,
        temperature=0.7
    )

    reply = tokenizer.decode(outputs[0], skip_special_tokens=True)
    print("Bot:", reply)
#