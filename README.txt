COPYRIGHT (C) 2015 8pecxstudios

Please read included licenses before using this Script|Software.

Instructions:

It uses 7zip and batch script.

To use it simply download the attached archive.
Extract the folder contained to a directory that is easily accessible and won't be accidentally deleted.

Run Backup.bat

If _Backups dose not exist it will be created in the current directory, This is were the backups are stored.

Now if cyberfox is running then it wont backup the profiles you will receive the warning like in the video above.
Now if your operating system is lower then windows 7 a unsupported os error message in the errorlog.log file will be generated.
Now it time stamps the profiles in the following format Date|Month|Year|Time, It also backs up the profiles.ini file in case you create a new profile or delete your profile directory.
Now it only works on the installed cyberfox and only on the default profile path "%userprofile%\AppData\Roaming\8pecxstudios"

Again it is very basic, It can run on the following operating systems 
windows 7
windows 8
windows 8.1
windows 10

Now this is a very rough backup script and with running batch scripts there some times can be unforeseen errors that can result in the loss of or damage of files etc, So its use at your own risk, Also the created archives with the profile data could become corrupt or damaged so loss of profile data may occur please read License.txt.

Note: You can create a windows task to activate Backup.bat at scheduled times to automate the backup process.