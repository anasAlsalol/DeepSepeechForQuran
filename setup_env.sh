#update docker container 

apt-get update -y
apt install python3-pip -y
apt-get install sox libsox-fmt-mp3 virtualenv python3-dev wget git zip -y
apt-get dist-upgrade -y


# Temp Download Data 

wget -O 'quran_data5sec.zip'  'https://nnaw8op9.clg07azjl.paperspacegradient.com/files/testGoogle/quran_data5sec.zip?token=07d82b3b81e188e57678933adc8e0514' 
unzip quran_data5sec.zip

# End Download the Data 

# Create DeepSpeech Env

mkdir venv
mkdir venv/deepspeech-train-venv
virtualenv -p python3.6 venv/deepspeech-train-venv/
source venv/deepspeech-train-venv/bin/activate
#git clone --branch quran https://github.com/anasAlsalol/DeepSpeech
cd DeepSepeechForQuran
pip3 install --upgrade pip==20.2.2 wheel==0.34.2 setuptools==49.6.0
pip3 install --upgrade -e .
pip3 uninstall tensorflow -y
pip3 install 'tensorflow-gpu==1.15.4'
python3 setup.py install

## train Model ## 

#bash ./bin/run-quran.sh > /artifacts/train_log.txt
bash ./bin/run-quran.sh > train_log.txt