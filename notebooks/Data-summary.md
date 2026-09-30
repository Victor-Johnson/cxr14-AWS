## Source
Hugging Face copy: BahaaEldin0/NIH-Chest-Xray-14, revision 932bcdba9d7d9590704d4f20bc70fc2c3a1bbad7
(community re-upload, empty README; original: NIH ChestX-ray14. Licence: verify at source.)

## Findings
- Provided splits are NOT patient-level: 5,359 of 7,211 test patients (74%) also appear in train.
- Re-split by patient (GroupShuffleSplit, seed 42): 70/10/20 → configs/patient_split_v1.csv
- 16 rows had impossible ages (max 414); age set to missing, images kept.
- No image filenames in this copy, so the official NIH split can't be recovered;
  results are not directly comparable to published numbers.
- Hernia: 158/21/48 images (train/valid/test) → report with a confidence interval.