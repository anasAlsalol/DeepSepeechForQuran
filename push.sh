git add . 
git commit -m "run job"
git push origin job
paperspace jobs create \
--container "paperspace/tensorflow:1.5.0-gpu" \
--machineType "G1" \
--command "bash setup_env.sh" \
--workspace "https://github.com/anasAlsalol/DeepSepeechForQuran.git" \
--workspaceRef "job" \
--isPreemptible true \
--project "DeepSpeech Model"
