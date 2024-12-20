%%
title: "GRUB menu: Linux version not detected"
date: "02-Nov-2024"
%%

# GRUB menu: Linux version not detected

If your grub installation doesn't detect the Linux versions properly, and
displays it wrong in the prompt menu at boot, like in my case in which appeared
as `Arch Linux with Linux version linux`, you can solve it by modifying the
helper scripts which grub uses to build the configuration file.

The problem is caused by the script `grub-mkconfig` which is used to build the
grub configuration file `grub.cfg` (generally located on `/boot/grub/`).

The script `grub-mkconfig` uses other helper scripts located on `/etc/grub.d/`,
and in particular the file used to detect the Linux version is
`/etc/grub.d/10_linux`, which uses the file name of the kernel file
to detect the version (for example `/boot/vmlinuz-6.1.0-25-amd64`). The issue is
caused on distributions like Arch Linux that doesn't add the suffix of version
to the main kernel file (for example `/boot/vmlinuz-linux`).

The solution is to to modify the file `/etc/grub.d/10_linux` and make the
following changes (also as a [diff file](https://gist.githubusercontent.com/mjkloeckner/214a0ee42c920affe572e12e933a1bb0/raw/24bda0dfa02c7baba3b983fb71662c1904645fa8/fix-grub-linux-display-version.diff)):

```diff
--- /etc/grub.d/10_linux
+++ /etc/grub.d/10_linux
@@ -144,7 +144,7 @@
     fi
     printf '%s\n' "${prepare_boot_cache}" | sed "s/^/$submenu_indentation/"
   fi
-  message="$(gettext_printf "Loading Linux %s ..." ${version})"
+  message="$(gettext_printf "Loading Linux %s ..." ${display_version})"
   sed "s/^/$submenu_indentation/" << EOF
 	echo	'$(echo "$message" | grub_quote)'
 	linux	${rel_dirname}/${basename} root=${linux_root_device_thisversion} rw ${args}
@@ -217,6 +217,7 @@
   dirname=`dirname $linux`
   rel_dirname=`make_system_path_relative_to_its_root $dirname`
   version=`echo $basename | sed -e "s,vmlinuz-,,g"`
+  display_version=`file $linux | grep -oP '(?<=version )\S*'`
   alt_version=`echo $version | sed -e "s,\.old$,,g"`
   linux_root_device_thisversion="${LINUX_ROOT_DEVICE}"
 
@@ -290,7 +291,7 @@
   fi
 
   if [ "x$is_top_level" = xtrue ] && [ "x${GRUB_DISABLE_SUBMENU}" != xtrue ]; then
-    linux_entry "${OS}" "${version}" simple \
+    linux_entry "${OS}" "${display_version}" simple \
     "${GRUB_CMDLINE_LINUX} ${GRUB_CMDLINE_LINUX_DEFAULT}"
 
     submenu_indentation="$grub_tab"
```

This modification makes the script `10_linux` get the Linux version, from the
output of the `file` command executed on the kernel file (for example `$ file
/boot/vmlinuz-linux`). *Note* that the output of the command is filtered using
GNU grep with Perl syntax (`-P` option) this allows the use of positive
look-behind regex `(?<=version)`.

* [Previous diff file as GitHub gist](https://gist.github.com/mjkloeckner/214a0ee42c920affe572e12e933a1bb0)
