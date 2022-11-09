%%
title: "I bought a ThinkPad x200 for $27"
date: "26-Oct-2022"
%%

# I bought a ThinkPad x200 for $27

A couple of week ago I was scrolling through Facebook marketplace when I saw what It looked like a ThinkPad published for exactly ARS$ 8000 (around USD $27). When I enter the publication it was effectively a ThinkPad, precisely an x200, but it was very dirty, this was the picture attached to the publication:
[![Thinkpad picture of the publication](owner-pic.jpeg)](owner-pic.png "Thinkpad picture of the publication")
The owner stated that the machine was working but it had no charger, that was a little bit suspicious ngl but, for the price, I couldn't be picky, I was looking for a cheap old ThinkPad like this for a while and this was the perfect oportunity.

So I contacted the owner, and we agree to meet the next day so I could pick it up. Fortunately the owner was about 30 minutes in public transport from my place so this was also a plus point for the publication.

When the owner give it to me obviously it was very dirty but also I felt like something inside was a little bit loose; the transaction was very quick, in a corner of a known intersection so, I didn't look at it very carefully.

When I arrived home and I started to look at it with more caution, the first thing that I noticed was that the loose part was the battery, so I didn't care much, but, before opening the lid I noticed that the lenovo branding was missing on the left bottom of the lid, and I panic a little since the day before going to pick up the x200 I saw a post which stated that cheap chinese clones of this machines where made, this cheap clones camed with an atom processor (trash compared to x200's processor) and they where smaller in size, and since they were clones, no lenovo branding was present on the clones. When I opened the lid I saw the "Intel Centrino" branding on the left bottom of the palm rest, and that was it, I thought that it was the cheap clone, so I leave on the desk and started to think about the trash that I thought I bought.
This a picture of the cheap clone, it looks identical but without the lenovo brandong

[![x200 chinese clone](x200_clone.jpeg)](x200_clone.png "x200 chinese clone")

After thinking (lasted 5 min max.) I started to look carefully at the machine again, and noticed that there was a lenovo branding on the bottom, so it couldn't be a copy, after searching for Intel Centrino on internet I found that it wasn't a processor but a network card, which the genuine x200 came with, so it actually was a *genunine ThinkPad*.

Since I hadn't the charger I couldn't try if it worked, so I started to deep clean it, at least all the exterior dirt, and the keyboard, which was disgusting.

[![Cleaning thinkpad dirty keyboard](cleaning-kb.jpeg)](cleaning-kb.png "Cleaning thinkpad dirty keyboard")

A couple of days later I picked up a used charger from a T430 (90w), and the TrackPoint cap which was also missing. When I connected the x200 to the grid the outter lid leds lit up, meaning the ThinkPad was receiving power and the battery  so I tried to turn it on, and for my surprise the computer booted to the BIOS *without a problem*.

## Updating the BIOS
After I plugged the computer in and it booted into the bios, I checked for the bios version and it was `3.11`. A quick check on lenovo's x200 webpage revealed that there were BIOS updates up until version `3.16`.
[![Old bios version](old-bios-version.jpeg)](old-bios-version.png "Old bios version")
I searched on Google on how to update the bios but I couldn't find a way without using Windows, there was [one way using Linux](https://www.thinkwiki.org/wiki/BIOS_update_without_optical_disk) but honestly in comparison with the Windows way was much more complicated. The most simple way for me was installing Windows, since Lenovo provides a Windows only BIOS updater tool. So I quickly installed Windows 7 on an 240GB kingston SSD which I had lying around and updated the BIOS, it was as simple as running the BIOS updater tool, clicking update and done.

## Installing an Operating System
After adding the SSD, installing Windows 7 and updating the BIOS, I was decided to install linux, I wanted to try void or artix (w/ runit), I had a previous machine with artix ([yt video showing how fast it booted](https://www.youtube.com/watch?v=dBdNQdocrVc)) for almost a year and it worked pretty well, I even gamed CS GO on it.
So I made a void linux bootable drive following the [void linux docs](https://docs.voidlinux.org/installation/live-images/prep.html), but, when I tried to boot into it, nothing. The BIOS wouldn't recognized the USB drive, I also tried making a bootable USB with [balenaEtcher](https://www.balena.io/etcher/) but again, nothing. The weird thing was that if I made an arch linux bootable USB using the previous both methods the BIOS would boot instantly. Because it was late, I ended up installing arch linux.
During the installation I noticed that the BIOS was not UEFI compatible, and that was the cause of all the trouble.
After I finished the installation and configuration of arch linux, I searched for a tool that would allow me to make legacy BIOS compatible boot mediums, I stumbled with [WoeUSB](https://github.com/WoeUSB), I made a void linux bootable usb drive with that tool and it booted instantly, so maybe in a future I will install void linux like I intended in the first place.

Anyway do you like my arch linux rice?
[![x200 arch linux rice](rice.jpeg)](rice.png "x200 arch linux rice")
I'm using suckless's [dwm](https://dwm.suckless.org/) and [st terminal](https://st.suckless.org/), firefox for the web browser and dolphin for the graphical file manager.
You can check out my [dotfiles](https://github.com/mjkloeckner/dotfiles) on github, although I didn't update them yet, but maybe at the time when you are reading this I already did.

## Using an x200 in 2022
The computer works perfectly, the only thing missing is OpenGL version 3.X support, because the integrated graphics card is old the last version supported is 2.1, so I couldn't make kitty nor alacritty terminals work. I ended up installing suckless's simple terminal (st), and it works like a charm, and it's very lightweight too.

The Core 2 Duo althought it has almost 15 years, it is still very usable for surfing the web and writing code, and general daily lightweight task. I'm planning to take the x200 to the University to write notes and check pdfs in the library, since the x200 only weight at around 1.6kg with the 90w charger, its more lightweight than my 2.0kg dell, it is also very small in dimension, the x200 is like a [netbook](https://en.wikipedia.org/wiki/Netbook) with steroids. The most impressive thing is how usable it is with only 2gb of RAM, when I saw in the BIOS that it only had 2gb of RAM I thought that it would be unusable tbh, but no, using dwm the idle ram usage is 200mb aprox. and with a couple of tabs opened in firefox and some terminals the RAM usage sits at around 1.3gb, of course I set a swap partition and when I open more tabs in firefox htop reports some swap usage, so the swap helps a bit.

This is the x200 compiling [translate shell](https://github.com/soimort/translate-shell) from source.
[![Compiling translate shell](compiling.jpeg)](compiling.png "Compiling translate shell")

Another picture of the x200, recording [MIDI](https://en.wikipedia.org/wiki/MIDI?wprov=sfla1) using [qtractor](https://qtractor.org/). I've also used the x200 for live MIDI processing, and it worked without a problem.
[![Recording midi on the x200](recording-midi.jpeg)](recording-midi.png "Recording midi on the x200")

## Things to do next

There is a ton of things that I want to try with this computer, like libreboot, swapping motherboards, running void linux, etc. But first I would like to disassemble it entirely to remove all the dust from the motherboard and replace the thermal paste. Also buy a 9-cell battery. The one that came with the computer only lasted around 10 minutes the first charge, after calibration I made it last an hour and a half. I saw a used 9-cell genuine lenovo near my place on MercadoLibre for the same price that I bought the x200 lol (around USD $27). So stay tuned to the blog post to read all the updates on the x200.
