timestamp=`date +%Y%m%d%H%M%S`
rm Logs/*.log #!/bin/bash

# Train TSDiff on the Uber dataset for the missing values experiment
python -m pdb  bin/train_model.py -c configs/train_tsdiff/train_missing_uber_tlc.yaml

# Train TSDiff on the KDDCup dataset for the missing values experiment
python bin/train_model.py -c configs/train_tsdiff/train_missing_kdd_cup.yaml

# Train TSDiff-Cond on the Uber dataset for the RM missing values experiment
python bin/train_cond_model.py -c configs/train_tsdiff-cond/missing_RM_uber_tlc_hourly.yaml

# Train TSDiff-Cond on the KDDCup dataset for the BM-B missing values experiment
python bin/train_cond_model.py -c configs/train_tsdiff-cond/missing_BM-B_kdd_cup_2018_without_missing.yaml

# Train TSDiff-Cond on the KDDCup dataset for the BM-E missing values experiment
python bin/train_cond_model.py -c configs/train_tsdiff-cond/missing_BM-E_kdd_cup_2018_without_missing.yaml

# Run observation self-guidance on the Solar dataset
python  -m pdb  bin/guidance_experiment.py -c configs/guidance/guidance_solar.yaml --ckpt 0   2>&1 |tee  -a Logs/$timestamp.log

# Run observation self-guidance on the KDDCup dataset
python bin/guidance_experiment.py -c configs/guidance/guidance_kdd_cup.yaml --ckpt 0  2>&1 |tee  -a Logs/$timestamp.log


# Refine predictions from the Linear model on the Solar dataset
python -m pdb  bin/refinement_experiment.py -c configs/refinement/solar_nips-linear.yaml --ckpt /path/to/ckpt   2>&1 |tee  -a Logs/$timestamp.log


# Refine predictions from the DeepAR model on the M4 dataset
nohup python bin/refinement_experiment.py -c configs/refinement/m4_hourly-deepar.yaml --ckpt /path/to/ckpt   2>&1 |tee  -a Logs/$timestamp.log


python  -m pdb  bin/guidance_experiment.py -c configs/guidance/guidance_uber_tlc.yaml  --ckpt ./lightning_logs/version_0/best_checkpoint.ckpt

python  -m pdb  bin/refinement_experiment.py -c configs/refinement/uber_tlc_hourly-linear.yaml  --ckpt ./lightning_logs/version_0/best_checkpoint.ckpt


python bin/refinement_experiment.py -c configs/refinement/solar_nips-linear.yaml --ckpt /path/to/ckpt
