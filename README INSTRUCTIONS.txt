Call of Duty 4: Survival Mode MW3 MOD Version 1.0 OPEN SOURCE
Date: May 2, 2020
By SPi.

Categories:

HOW TO WORK WITH SURVIVAL MODE 
MODE INFO
SURVIVAL MODE FUNCTIONALITY
KNOWN BUGS
CREDITS

Useful Call of Duty 4 Singleplayer Level Making Tutorials:
https://www.youtube.com/watch?v=rQ7W1xWVHEw&list=PLfPZdzppHBCqkM9rk9HLkLs8fjVVMSAj_

In case you create your own variation of the game mode, please make sure to give it a proper title 
that describes its functionality changes and difference from other versions that might come. 
Just please make sure to give credits to SPi and Scillman for the hard work of putting together 
the basic version of it which started it all.

Important: If you make a different mod version of this make sure to rename your new
mod folder with a new and different name. Do NOT release modified versions of this mod with
mod folder named survival_mw3 because there will be conflicts with other versions.

######################################
HOW TO WORK WITH SURVIVAL MODE:
######################################

The content of this download package contains a lot of assets and files that allow modders to
create their own CALL OF DUTY 4 SURVIVAL MODE MW3 MOD Levels or even their own version of the mode.
In order to understand the procedure that is required to do so, you have to read through 
most of the TEXT info I have included with this download. 

THIS IS NOT A PLAYABLE DOWNLOAD!
YOU NEED MOD TOOLS TO COMPILE AND PLAY THE MODE!
AND OTHER PLAYABLE UPLOAD LINK SHOULD BE PROVIDED 
FROM THE SITE WHERE THIS FILE CAME FROM.

It goes without saying that in order to use that package you are required
to have the Official Call of Duty 4 Mod Tools installed and properly set up.
This means that once you have installed the mod tools,
you need to open the Compile Tools from the Bin Folder
and in the Applications tab, run converter.
Let it finish and NEVER run it again.
That converter is required to run before you use COD4 Mod tools.
It sets up some required raw files for the mod system to function.
However there's a small problem with this converter that tends to delete 
a material for m4 and m16 causing it to appear invisible in new maps.
Don't worry, i've included the missing file with this download.
it goes is located in this download's files raw/materials
and it must go in your game files raw/materials.

It is also suggested that you unpack all of your iwd sound assets in raw/sounds.
If you know how to rip sounds from fast files, it is also suggested to get 
these sounds in raw/sounds too. But only if you know how. Don't bother if you don't.

First of all lets break down what the contents of this package includes.
The main folder of the download has 3 files.

FOLDER: COD4_SURVIVAL_MW3_MOD_SOURCE_FILES
FOLDER: SPiAppTool
TEXT FILE: README INSTRUCTIONS

You are currently reading README INSTRUCTIONS.TXT

COD4_SURVIVAL_MW3_MOD_SOURCE_FILES folder has all the necessary files for the mode.
You can chose to either work just with the raw files, or combine them with my SPiAppTool 
to make your life easier when making maps on call of duty 4.

If you wish to learn more about what my SPiAppTool is, 
read the SPIAPP GUIDE.TXT in the folder SPiAppTool.

Now to start working with COD4 Survival source files,
you must read the (COD4 SURVIVAL GUIDE.TXT) file
in the COD4 Survival Mode Source Files folder.

There are plenty of folders in there.
I did my best to include all the files.

This current introduction basically urges you to read the guides in the sub-folders.
And lets you have a basic understanding of how to use these files.

######################################
SURVIVAL MODE FUNCTIONALITY:
######################################

The mode is made in a way that it resembles MW3 Survival Mode in most, if not all, functions.

The game starts by spawning player with a weapon and limited equipment.
Then the waves start. Each wave spawns an amount of enemy NPCs that attack player in the limited map area.
All enemies killed. Wave is successful.
Each enemy kill gives money to player. The higher the enemy tier, the higher the price.
5 regular enemy tiers in total. Just like MW3.
Every 5 waves, a heavy wave occurs.
Heavy waves are bringing either Juggernauts or Enemy Attack Helicopters against player.
They also have cash reward on player kill.

WAVE STRUCTURE:-------------------

Here's a short breakdown of how the first waves are structured:

Wave 1 to 3. Tier 1 enemies.
Wave 4 to 9. Tier 2 enemies.
Wave 11 to 14. Tier 3 enemies.
Wave 16 to 19. Tier 4 enemies.
Wave 21 and forever. Tier 5 enemies.

Heavy Waves go as following:

Wave 6. Easy Heavy Wave:
(1x AttackHeli) OR (1x Juggernaut)

Wave 10. Medium Heavy Wave:
(2x Juggernaut) OR (2x AttackHeli) OR (1x AttackHeli + 1x Juggernaut)

Wave 15. Hard Heavy Wave:
(2x AttackHeli + 1x Juggernaut) OR (1x AttackHeli + 2x Juggernaut) OR ( just 2x AttackHeli)

Wave 20. Veteran Heavy Wave:
(2x AttackHeli + 3x Juggernaut)

Wave 25 (and every 5 waves from now on)
Insane Heavy Wave:
(2x AttackHeli + 3x Juggernaut) + Around 10 Regular Tier 5 Enemies.

Also in some waves after 20 the juggernauts may be Either Normal(+500), "Shield"+(750) or Heavy(+1000)
Since COD4 can't support riot shield, I simulated the feel of MW3 Shielded Juggernauts.
This way the Juggernaut will stay crouched and move to player and when 2/3 of his health is gone
he stands up and walks like normal juggernaut.

STORES:-------------------

After Wave 1 is completed, the Weapon Armory Store is open and available to player.
After Wave 2 is completed, the Equipment Armory Store is open and available to player.
After Wave 3 is completed, the Air Support Armory Store is open and available to player.

All armories are working very similar to MW3 Survival Armories.
You can buy weapons, equipment, perks, reinforcements or air support from the corresponding armory.
Some features aren't like MW3, because of the game limits and my limited time and skills,
like the predator missile is replaced from a clumsy jet air strike I scripted.
Most of the perks are missing because Call of Duty 4 Singleplayer doesn't support MP perks.
Only 2 are implemented plus the two body armor and self revive "equipment" perks.
That's how MW3 had them and that's how I made it.

All prices are set in a way to resemble MW3 prices.

There's also one buy-able ending as custom feature.
It's nothing too fancy, it just ends the game saying you won giving you the gameover end stat screen.

PLAYER HEALTH SYSTEM:-------------------

A fake player health system is implemented because the default one wouldn't work well with the mode.
Basically player never dies. His health value is increased every time he receives damage.
However there is a fake player health value that is set.
Every time player takes damage, it reduces based on the damage amount player received.
After a few seconds, it recharges. More or less like the default one.
However, there are body armor and self revive perks.
Body armor is a second fake health that boosts player fake health.
It doesn't recharge. And if it hits zero, it goes away and the normal fake player health is applied as explained above.
If player wants to get it back, he can simply re-buy it from the store.

Last Stand Perk, checks if player has the perk. And when player fake health reaches ZERO.
Player is locked in prone position with slow movement, and is given a pistol.
His other weapons are stored.
Enemies won't shoot at him when revived.
Once self revive is completed. Player is back on his feet given his previous weapons.
If he looses all fake health again, the game ends. But player still doesn't actually die.
All of his gear is taken, and he is locked on prone stance.
And the end screen menu appears.
Of course player can re-buy self revive if he has the money to prevent him from losign the game.

CHEATS:-------------------

You can use some custom cheats I implemented for the sake of that mode.
But do NOT use cheats on your first couple of tests. Either custom or default ones.
Try to play it normally at first so the health balance is tested roughly.

To use the the mode's cheats, you must be in the level, drop console, and type:
/spi_devhack 1
hit enter. Close console.

Now this cheat system is specifically for this game mode.
It won't have any affect anywhere else.
And it's hardcoded so it's going to be using specific buttons.

B for Increase Money +1000
V for Decrease Money -1000
+ for +1 wave (this is buggy, it's not suggested to use)
- for -1 wave (this is buggy, it's not suggested to use)
Typing the word "NOT" while enemies being alive kills all enemies except helicopters.
This one is glitchy try not to overuse it. It may sometimes give minus number of enemies.
Retype it to reset it to zero.

######################################
KNOWN BUGS:
######################################

> It is likely that the Red Airstrike Smoke would pop out normal smoke as well. Very low possibilities but likely.
> It is also likely that some NPCs can be seen spawning.
> The Jet Airstrike Marker can be called off map even on the skybox. (Try calling it on a stopped enemy attack helicopter)
> Juggernauts have a few seconds delay before the juggernaut logic is applied to them once they land.
 This can cause serious problems if the health shield is somehow bypassed and they are killed before they land.
 The NPC counter won't remove the unit of the Juggernaut NPC and it will get stuck in the wave.
 Only way to skip this is use the cheats above to clear the wave. Someone can fix it in the _survspi.gsc
> Player can instantly die if he cook a grenade for too long even if he has last stand.
> The damage system isn't roughly tested but it seems to work fine.
Every weapon has different stats so the damage testing may differ
form user to user and it may not feel like WM3.
> There are plenty of leftover functions from features I either canceled or commented to keep it more like MW3.
Such functions are, the dog system which needs more work I can not do.
The Ally Helicopter overwatch air support killstreak which I don't want to work on at all.
Various perks and weapons.
And finally the Hero Team Reinforcement. Which is pretty easy to bring back and completely functional.
> Shotgun enemies use a different set of animations which sometimes can make the NPC model stretch horizontally and look very odd.
That's a COD4 related bug. Not mine. Just so you know in case you come across it.
> There may be more I forgot to mention.

######################################
CREDITS:
######################################

A ton of thanks to my very good online friend and programmer helper Scillman.
Most of the features I implemented would either take too much time or never been
completed if it wasn't for his valuable help. Not only in this mode.
But in most of my projects. Also special thanks to Erik and NikolaiBelinski.
Also special thanks to Stendby for making the addon maps for this mode.

Addon maps are not included in this package for practical reasons.
