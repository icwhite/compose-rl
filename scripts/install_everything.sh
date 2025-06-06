
git clone https://github.com/icwhite/compose-rl.git
cd compose-rl
pip install -e .[gpu]
python3 -m spacy download en_core_web_sm

cd scripts
python data/unified_tokenize_dataset.py --dataset_name izzcw/dpo_pairs_crafting_filtered \
--local_dir pref_data \
--dataset_type preference \
--tokenizer_name meta-llama/Llama-3.1-8B-Instruct \
--split train

cd ..
cd ..
git clone https://github.com/mosaicml/llm-foundry.git
cd llm-foundry
pip install -e ".[gpu]"  # or `pip install -e .` if no NVIDIA GPU.

composer llm-foundry/scripts/train/train.py \
compose-rl/yamls/local_dpo.yaml \
train_loader.dataset.local=/compose-rl/scripts/pref_data/ \
train_loader.dataset.split=train