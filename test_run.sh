#update docker container 
apt-get update -y
apt-get install wget -y

# Download the Data 
wget -O goodls https://github.com/tanaikech/goodls/releases/download/v1.2.7/goodls_linux_amd64
chmod +x ./goodls
bash ./goodls -u 'https://drive.google.com/drive/folders/1lE94p1pOqMiGcUgbU9-AjhKAXRbdQpd_?usp=sharing' --overwrite
mv Quran_Data_ForBaseModel_5sec quran_data
cd quran_data/quran
unzip *.zip
mv notebooks/quran_data/quran/wav/ wav
rm -rf notebooks
cd ..
cd quran_tusers
unzip *.zip
mv notebooks/quran_data/quran_tusers/wav/ wav
rm -rf notebooks
cd ..