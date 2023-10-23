# perl-gzip-script

Gzip perl scripts to reduce their file size.

# Example

Applying perl-gzip-script to cpm,
the size of cpm script is reduced from 731K to 189K.

```console
$ curl -fsSL https://raw.githubusercontent.com/skaji/cpm/main/cpm > cpm

$ perl script/perl-gzip-script cpm > cpm-gzip

$ ls -alh cpm*
-rw-r--r-- 1 skaji staff 731K Sep 30 06:48 cpm
-rw-r--r-- 1 skaji staff 189K Sep 30 06:48 cpm-gzip

# ... and cpm-gzip works!
$ perl cpm-gzip install Plack
DONE install Apache-LogFormat-Compiler-0.36
DONE install Test-TCP-2.22
...
DONE install Plack-1.0050
18 distributions installed.
```

# Author

Shoichi Kaji

# License

The same as Perl
