# Bandits writeups

# **level 0**

```
ssh bandit0@bandit.labs.overthewire.org -p2220
```
 To log into the server.

Key : `bandit0`

# **level 1**

Reading a file using cat command

```
ls
cat readme
```

Key: `NH2SXQwcBdpmTEzi3bvBHMM9H66vVXjL`

# **level 2**

Contains the use of full path of file so that dashed filename can be passed

`cat ./-`

Key : `rRGizSaX8Mk1RTb1CNQoXTcYZWU6lgzi`

# **level 3**

Conatins spaces in the file name so needed to specify filename such that spaces are also included.

` cat ./'spaces in this filename'` works where cat command is used to display the contents of file in terminal.

Key : `aBZ0W5EmUfAf7kHTQeOwd8bauFJ2lAiG`

# **level 4**

To clear this level you to navigate to the `inhere` directory and view hidden files and display it using `cat` command

```
ls
cd inhere
ls -a #Displays all the hidden files
.  ..  .hidden
```
Now you know that the filename of hildden file is ".hidden" and can now be accessed.

`cat .hidden` Displays content of file ".hidden"

Key : `2EW7BBsr6aMMoJ2HjW067dm8EgX26xNe`

# **level 5**

According to instruction, we need to find the file which is human readable.

The `file` command is used to display the type of the file, and we will use that only to find the file which is human readable.

```
cd inhere
ls
```

`-file00  -file01  -file02  -file03  -file04  -file05  -file06  -file07  -file08  -file09`

We note that all the file names are of the form `-file0*`. Now we can use the `file` command to display the type of each file having file name of type `-file0*`

`file ./-file0*`

```
./-file00: data
./-file01: data
./-file02: data
./-file03: data
./-file04: data
./-file05: data
./-file06: data
./-file07: ASCII text
./-file08: data
./-file09: data
```

Now the file with ASCII text must have the key and can be displayed.

` cat ./-file07`

Other method could have been to use the grep command to pipe the output to find the file with ASCII text.

`file ./-file0* | grep ASCII`

`./-file07: ASCII text`

Which also shows that -file07 has the required key.

Key : `lrIWWI6bB37kxfiCQZqUdOIYfr6eEeqR`

# **level 6**

The objective is to find a file which is human readable, of size 1033 bytes and not executable.

For that we will be using find command, which is used to find a file with specific properties in a file heirarchy.

```
bandit5@bandit:~$ ls
inhere
bandit5@bandit:~$ cd inhere
bandit5@bandit:~/inhere$ ls
maybehere00  maybehere03  maybehere06  maybehere09  maybehere12  maybehere15  maybehere18
maybehere01  maybehere04  maybehere07  maybehere10  maybehere13  maybehere16  maybehere19
maybehere02  maybehere05  maybehere08  maybehere11  maybehere14  maybehere17
```

```
bandit5@bandit:~/inhere$ find . -type f -size 1033c ! -executable -exec file '{}' \; | grep ASCII
./maybehere07/.file2: ASCII text, with very long lines (1000)
bandit5@bandit:~/inhere$ cat ./maybehere07/.file2
P4L4vucdmLnm8I7Vl7jG1ApGSfjYKqJU
```

We found all the files of 1033 bytes and that were not executable then we used -exec to run file command on each found file. Then we piped the input into grep to find 'ASCII' in output.

One of the flaws in this level is that there exists only one file which is 1033 bytes long so even if I did only `find . -size 1033c` then also I will narrow down to a single file.

Key : `P4L4vucdmLnm8I7Vl7jG1ApGSfjYKqJU`

# **level 7**

The objective of this level is to find the file which is stored somewhere in the server and having the following properties

- size is 33 bytes
- owned by user bandit7
- owned by group bandit6
  Again this is an application of find command. The thing to note here is that we want to search all of directories. So we must use / in path istead of . as then it will search only current directory.

```
bandit6@bandit:~$ find / -type f -user bandit7 -group bandit6 -size 33c
```

This also gives many permission denied messages but also gives to path of a file which we then display to get the key.

```
bandit6@bandit:~$ cat /var/lib/dpkg/info/bandit7.password
z7WtoNQU2XfjmMtWA8u5rN4vzqu4v99S
```

Key : `z7WtoNQU2XfjmMtWA8u5rN4vzqu4v99S`

# **level 8**

The objective of the level is to find the key which is adjacent to word millionth in the file data.txt
We will use grep command to find the contents of the line which contains the word millionth.

There are two methods to do so.

```
bandit7@bandit:~$ cat data.txt | grep millionth
millionth       TESKZC0XvTetK0S9xNwm25STk5iWrBvP

```

```
bandit7@bandit:~$ grep millionth data.txt
millionth       TESKZC0XvTetK0S9xNwm25STk5iWrBvP
```

In the first method we are displaying contents of data.txt using cat and piping the output in grep to find the word millionth. While in second we are following basic syntax of grep directly.

Key : `TESKZC0XvTetK0S9xNwm25STk5iWrBvP`

# **level 9**

The password for the next level is stored in the file data.txt and is the only line of text that occurs only once.
We will be using uniq command for this which filters lines based on identical lines. The -u flag allows it to display only unique lines.

But if we run this command `uniq data.txt -u` at once then we will get many lines as unique because there is a flaw in our approach that the lines passed in the uniq must be sorted first for it to work.

So we use sort command to sort the lines first before sending to the uniq command.

```
bandit8@bandit:~$ sort data.txt | uniq -u
EN632PlfYiZbn3PhVK3XOGSlNInNE00t
```

Key : `EN632PlfYiZbn3PhVK3XOGSlNInNE00t`

# **level 10**

We know that password is in data.txt along as some human readable text followed by some = characters.

```
bandit9@bandit:~$ strings data.txt | grep =
=2""L(
x]T========== theG)"
========== passwordk^
Y=xW
t%=q
========== is
4=}D3
{1\=
FC&=z
=Y!m
        $/2`)=Y
4_Q=\
MO=(
?=|J
WX=DA
{TbJ;=l
[=lI
========== G7w8LIi6J3kTb8A7j9LgrywtEUlyyp6s
>8=6
=r=_
=uea
zl=4
```

Used strings command to find the human readable strings in the file and then piped the output of human readable strings to grep to find = characters.
Key: `G7w8LIi6J3kTb8A7j9LgrywtEUlyyp6s`

# **level 11**

Given that the data is encoded in base64 in data.txt. So basic objective is to first decode the file then read the contents.

```
bandit10@bandit:~$ base64 data.txt -d
The password is 6zPeziLdR2RKNdNYFNb6nVCKzphlXHBM
```

The flag -d is for decoding.
Key : `6zPeziLdR2RKNdNYFNb6nVCKzphlXHBM`

# **level 12**

Given that there is a rotation of 13 letters. We will use tr command to translate characters from one set to that of another set.

```
bandit11@bandit:~$ cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
The password is JVNBBFSmZwKKOP0XbFXOoW8chDz5yVRv
```

Key: `JVNBBFSmZwKKOP0XbFXOoW8chDz5yVRv`

# **level 13**

This level uses multiple stages of compression and we were supposed to identify which type of compression it is and then extract it and proceed.

First I created a different directory in temp, copied the file there and then renamed the file

```
bandit12@bandit:~$ mkdir /tmp/hawkeye
bandit12@bandit:~$ cp data.txt /tmp/hawkeye/data.txt
bandit12@bandit:~$ cd /tmp/hawkeye
bandit12@bandit:/tmp/hawkeye$ mv data.txt data11.txt
```

```
bandit12@bandit:/tmp/hawkeye$ cat data11.txt
00000000: 1f8b 0808 6855 1e65 0203 6461 7461 322e  ....hU.e..data2.
...
```

The hexdumps first line can tell about the type of file and so we can get to know its compression type. Looking on internet one cn find 1f8b is for gzip compression. So we reverse the hexdump to a new file and then rename it as a .gz file then decompress it using gzip command.

```
bandit12@bandit:/tmp/hawkeye$ xxd -r data11.txt data12.txt
bandit12@bandit:/tmp/hawkeye$ mv data12 data12.gz
bandit12@bandit:/tmp/hawkeye$ gzip -d data12.gz
bandit12@bandit:/tmp/hawkeye$ ls
data11.txt  data12
bandit12@bandit:/tmp/hawkeye$ cat data12
�h44�z��A����@=�h4hh�␦␦␦��hd�����1����������;,�
...
```

Next we create hexdump again to find the compression type.

```
bandit12@bandit:/tmp/hawkeye$ xxd data12 data13
bandit12@bandit:/tmp/hawkeye$ cat data13 | head
00000000: 425a 6839 3141 5926 5359 481b 3202 0000  BZh91AY&SYH.2...
...
```

425a is for bzip2 compression

```
bandit12@bandit:/tmp/hawkeye$ mv data12 data12.bz2
bandit12@bandit:/tmp/hawkeye$ ls
data11.txt  data12.bz2  data13
bandit12@bandit:/tmp/hawkeye$ bzip2 -d data12.bz2
bandit12@bandit:/tmp/hawkeye$ ls
data11.txt  data12  data13
```

```
/tmp/hawkeye$ xxd data12 data14
bandit12@bandit:/tmp/hawkeye$ cat data14 | head
00000000: 1f8b 0808 6855 1e65 0203 6461 7461 342e  ....hU.e..data4.
...
```

Again gzip compression

```
bandit12@bandit:/tmp/hawkeye$ mv data12 data12.gz
bandit12@bandit:/tmp/hawkeye$ gzip -d data12.gz
bandit12@bandit:/tmp/hawkeye$ ls
data11.txt  data12  data13  data14
```

```
bandit12@bandit:/tmp/hawkeye$ xxd data12 data15
bandit12@bandit:/tmp/hawkeye$ cat data15
00000000: 6461 7461 352e 6269 6e00 0000 0000 0000  data5.bin.......
...
```

Now this was complicated for me to find out but as some last characters of the file mentions data5.bin then it most probably is a compressed file of data5.bin. We decompress it using `tar -xf` command.

```
bandit12@bandit:/tmp/hawkeye$ mv data12 data12.tar
bandit12@bandit:/tmp/hawkeye$ tar -xf data12.tar
bandit12@bandit:/tmp/hawkeye$ ls
data11.txt  data12.tar  data13  data14  data15  data5.bin
```

```
bandit12@bandit:/tmp/hawkeye$ xxd data5.bin data16
bandit12@bandit:/tmp/hawkeye$ cat data16
00000000: 6461 7461 362e 6269 6e00 0000 0000 0000  data6.bin.......
```

Again it looks like a compression of data6.bin

```
bandit12@bandit:/tmp/hawkeye$ tar -xf data5.bin
bandit12@bandit:/tmp/hawkeye$ ls
data11.txt  data12.tar  data13  data14  data15  data16  data5.bin  data6.bin
```

```
bandit12@bandit:/tmp/hawkeye$ xxd data6.bin data17
bandit12@bandit:/tmp/hawkeye$ cat data17 | head
00000000: 425a 6839 3141 5926 5359 0403 8894 0000  BZh91AY&SY......
...
```

Again bzip2 compression.

```
bandit12@bandit:/tmp/hawkeye$ mv data6.bzip2 data6.bz2
bandit12@bandit:/tmp/hawkeye$ ls
data11.txt  data12.tar  data13  data14  data15  data16  data17  data5.bin  data6.bz2
bandit12@bandit:/tmp/hawkeye$ bzip2 -d data6.bz2
bandit12@bandit:/tmp/hawkeye$ ls
data11.txt  data12.tar  data13  data14  data15  data16  data17  data5.bin  data6
bandit12@bandit:/tmp/hawkeye$ cat data6
data8.bin0000644000000000000000000000011714507452550011255 0ustar  rootroohUedata9.bin
...
```

Again data6 is a compressed archive.

```
bandit12@bandit:/tmp/hawkeye$ tar -xf data6
bandit12@bandit:/tmp/hawkeye$ ls
data11.txt  data12.tar  data13  data14  data15  data16  data17  data5.bin  data6  data8.bin
bandit12@bandit:/tmp/hawkeye$ xxd data8.bin data18
bandit12@bandit:/tmp/hawkeye$ cat data18
00000000: 1f8b 0808 6855 1e65 0203 6461 7461 392e  ....hU.e..data9.
...
```

```
bandit12@bandit:/tmp/hawkeye$ mv data8.bin data8.gz
bandit12@bandit:/tmp/hawkeye$ ls
data11.txt  data12.tar  data13  data14  data15  data16  data17  data18  data5.bin  data6  data8.gz
bandit12@bandit:/tmp/hawkeye$ gzip -d data8.gz
bandit12@bandit:/tmp/hawkeye$ ls
data11.txt  data12.tar  data13  data14  data15  data16  data17  data18  data5.bin  data6  data8
bandit12@bandit:/tmp/hawkeye$ cat data8
The password is wbWdlBxEir4CaE8LaPhauuOo6pwRmrDw
```

Key: `wbWdlBxEir4CaE8LaPhauuOo6pwRmrDw`

# **level 14**

As instructed we don't get a key this time but we get a private key that can be used to log in.

```
bandit13@bandit:~$ ls
sshkey.private
```

So now we know the location of private key. And we can transfer it on our machine so that we can login to the next level using the scp command.

```
scp -P 2220 bandit13@bandit.labs.overthewire.org:sshkey.private .
chmod 700 sshkey.private
ssh -i sshkey.private bandit14@bandit.labs.overthewire.org -p 2220
```

We change the file permissions of the sshkey.private so that only owner has all the rwx permissions. Then we login with ssh command with -i flag which specifies the location of key.

# **level 15**

Now we are logged in as user bandit14 so we can have the acces of file which contains the password of previous level.

```
bandit14@bandit:~$ cat /etc/bandit_pass/bandit14
fGrHPx402xGC7U7rXKDaxiWFTOiF0ENq
```

According to instructions we need to submit it to port 30000 on localhost to get the password of next level.
nc is a command that can be used to write data over a connection.

```
bandit14@bandit:~$ nc localhost 30000
fGrHPx402xGC7U7rXKDaxiWFTOiF0ENq
Correct!
jN2kgmIXJ6fShzhT2avhotn4Zcka6tnt
```

Key: `jN2kgmIXJ6fShzhT2avhotn4Zcka6tnt`

# **level 16**

`openssl s_client` can be used to connect with SSL encryption.

```
bandit15@bandit:~$ openssl s_client -connect localhost:30001
CONNECTED(00000003)
...
jN2kgmIXJ6fShzhT2avhotn4Zcka6tnt
Correct!
JQttfApK4SeyHwDlI9SXGR50qclOAil1

closed
```

Key : `JQttfApK4SeyHwDlI9SXGR50qclOAil1`

# **level 17**

For this level we need to scan over the ports on localhost in the range 31000 to 32000 and look for an open port which can provide us with the password for the next level. The `nmap` command can be used to scan through the different ports, the -p flag specifies the ports to scan through and localhost specifies the target.

```
bandit16@bandit:~$ nmap -sV localhost -p 31000-32000
Starting Nmap 7.80 ( https://nmap.org ) at 2024-03-15 12:51 UTC
Nmap scan report for localhost (127.0.0.1)
Host is up (0.00010s latency).
Not shown: 996 closed ports
PORT      STATE SERVICE     VERSION
31046/tcp open  echo
31518/tcp open  ssl/echo
31691/tcp open  echo
31790/tcp open  ssl/unknown
31960/tcp open  echo
...
```

31790 seems to be a promising port as it uses ssl and also unknown.

```
bandit16@bandit:~$ openssl s_client -connect localhost:31790
CONNECTED(00000003)
...
JQttfApK4SeyHwDlI9SXGR50qclOAil1
Correct!
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAvmOkuifmMg6HL2YPIOjon6iWfbp7c3jx34YkYWqUH57SUdyJ
imZzeyGC0gtZPGujUSxiJSWI/oTqexh+cAMTSMlOJf7+BrJObArnxd9Y7YT2bRPQ
Ja6Lzb558YW3FZl87ORiO+rW4LCDCNd2lUvLE/GL2GWyuKN0K5iCd5TbtJzEkQTu
DSt2mcNn4rhAL+JFr56o4T6z8WWAW18BR6yGrMq7Q/kALHYW3OekePQAzL0VUYbW
JGTi65CxbCnzc/w4+mqQyvmzpWtMAzJTzAzQxNbkR2MBGySxDLrjg0LWN6sK7wNX
x0YVztz/zbIkPjfkU1jHS+9EbVNj+D1XFOJuaQIDAQABAoIBABagpxpM1aoLWfvD
KHcj10nqcoBc4oE11aFYQwik7xfW+24pRNuDE6SFthOar69jp5RlLwD1NhPx3iBl
J9nOM8OJ0VToum43UOS8YxF8WwhXriYGnc1sskbwpXOUDc9uX4+UESzH22P29ovd
d8WErY0gPxun8pbJLmxkAtWNhpMvfe0050vk9TL5wqbu9AlbssgTcCXkMQnPw9nC
YNN6DDP2lbcBrvgT9YCNL6C+ZKufD52yOQ9qOkwFTEQpjtF4uNtJom+asvlpmS8A
vLY9r60wYSvmZhNqBUrj7lyCtXMIu1kkd4w7F77k+DjHoAXyxcUp1DGL51sOmama
+TOWWgECgYEA8JtPxP0GRJ+IQkX262jM3dEIkza8ky5moIwUqYdsx0NxHgRRhORT
8c8hAuRBb2G82so8vUHk/fur85OEfc9TncnCY2crpoqsghifKLxrLgtT+qDpfZnx
SatLdt8GfQ85yA7hnWWJ2MxF3NaeSDm75Lsm+tBbAiyc9P2jGRNtMSkCgYEAypHd
HCctNi/FwjulhttFx/rHYKhLidZDFYeiE/v45bN4yFm8x7R/b0iE7KaszX+Exdvt
SghaTdcG0Knyw1bpJVyusavPzpaJMjdJ6tcFhVAbAjm7enCIvGCSx+X3l5SiWg0A
R57hJglezIiVjv3aGwHwvlZvtszK6zV6oXFAu0ECgYAbjo46T4hyP5tJi93V5HDi
Ttiek7xRVxUl+iU7rWkGAXFpMLFteQEsRr7PJ/lemmEY5eTDAFMLy9FL2m9oQWCg
R8VdwSk8r9FGLS+9aKcV5PI/WEKlwgXinB3OhYimtiG2Cg5JCqIZFHxD6MjEGOiu
L8ktHMPvodBwNsSBULpG0QKBgBAplTfC1HOnWiMGOU3KPwYWt0O6CdTkmJOmL8Ni
blh9elyZ9FsGxsgtRBXRsqXuz7wtsQAgLHxbdLq/ZJQ7YfzOKU4ZxEnabvXnvWkU
YOdjHdSOoKvDQNWu6ucyLRAWFuISeXw9a/9p7ftpxm0TSgyvmfLF2MIAEwyzRqaM
77pBAoGAMmjmIJdjp+Ez8duyn3ieo36yrttF5NSsJLAbxFpdlc1gvtGCWW+9Cq0b
dxviW8+TFVEBl1O4f7HVm6EpTscdDxU+bCXWkfjuRb7Dy9GOtt9JPsX8MBTakzh3
vBgsyi/sN3RqRBcGU40fOoZyfAMT8s1m/uYv52O6IgeuZ/ujbjY=
-----END RSA PRIVATE KEY-----

closed
```

Now we create a file with this RSA key on our local machine to connect to the next level.

```
touch newkey.private
cat > newkey.private
...
chmod 700 newkey.private
 ssh -i newkey.private bandit17@bandit.labs.overthewire.org -p2220
```

# **level 18**

Diff command can be used to find the difference between two files.

```
bandit17@bandit:~$ diff passwords.new passwords.old
42c42
< hga5tuuCLF6fFzUpnagiMN8ssu9LFrdg
---
> p6ggwdNHncnmCNxuAt0KtKVq185ZU7AW
```

Key : `hga5tuuCLF6fFzUpnagiMN8ssu9LFrdg`

# **level 19**

The .bashrc script is modified so that one logs out just after logging in. The ssh command can also be used to run simultaneous commands.

```
aadex@DESKTOP-QC3OI87:~$ ssh bandit18@bandit.labs.overthewire.org -p2220 cat readme
                         _                     _ _ _
                        | |__   __ _ _ __   __| (_) |_
                        | '_ \ / _` | '_ \ / _` | | __|
                        | |_) | (_| | | | | (_| | | |_
                        |_.__/ \__,_|_| |_|\__,_|_|\__|


                      This is an OverTheWire game server.
            More information on http://www.overthewire.org/wargames

bandit18@bandit.labs.overthewire.org's password:
awhqfNnAbc1naukrpqDYcF95h7HoMTrC
```

Key: `awhqfNnAbc1naukrpqDYcF95h7HoMTrC`

# **level 20**

Running the `ls -la` command we get to see that file `bandit20-do` file has user group bandit19 with execute permission.

On executing the `bandit20-do` script. It says that it allows to run commands as bandit 20 user. So we can access the password file stored in /etc/bandit_pass

```
bandit19@bandit:~$ ./bandit20-do
Run a command as another user.
  Example: ./bandit20-do id
bandit19@bandit:~$ ./bandit20-do ls /etc/bandit_pass
bandit0   bandit11  bandit14  bandit17  bandit2   bandit22  bandit25  bandit28  bandit30  bandit33  bandit6  bandit9
bandit1   bandit12  bandit15  bandit18  bandit20  bandit23  bandit26  bandit29  bandit31  bandit4   bandit7
bandit10  bandit13  bandit16  bandit19  bandit21  bandit24  bandit27  bandit3   bandit32  bandit5   bandit8
bandit19@bandit:~$ ./bandit20-do cat /etc/bandit_pass/bandit20
VxCazJaVykI6W36BkBU0mJTCM8rR95XT
```
Key: `VxCazJaVykI6W36BkBU0mJTCM8rR95XT`
