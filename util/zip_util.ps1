$amount_thr  = @{
    '100p' = 9999999
    '70p'  = 799000
    '50p'  = 560000
    '30p'  = 260000
    '5sec' = 160000
    }

#quran_tusers
#quran
$amount_thr.Keys | % {
$filename = -join($_,'.txt')
$tempfilename = -join($_,'.tmp')
$wav_filesize = $amount_thr.Item($_)
Import-CSV "/notebooks/quran_data/quran_tusers/csv/quran_all.csv" |  Where-Object {$_.wav_filesize -lt $wav_filesize} | Select wav_filename  | Out-File -FilePath $tempfilename
cat $tempfilename | % {$_.replace("data/","/notebooks/quran_data/")} | out-file $filename
rm $tempfilename
}

#quran_tusers

#(Get-Content '.\MyList.txt') -notmatch $re | Set-Content '.\output.txt'

cat  5sec.txt | zip -@ 5sec.zip
compare-object (get-content 30p.txt) (get-content ./5sec.txt) | Select InputObject  | zip -@ 30p.zip
compare-object (get-content 50p.txt) (get-content ./30p.txt) | Select InputObject  | zip -@ 50p.zip
compare-object (get-content 70p.txt) (get-content ./50p.txt) | Select InputObject  | zip -@ 70p.zip
compare-object (get-content 100p.txt) (get-content ./70p.txt) | Select InputObject  | zip -@ 100p.zip