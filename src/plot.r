library(scales)
library(zoo)

lh = read.csv("../dat/light.csv", header = TRUE)
pr = read.csv("../dat/prysm.csv", header = TRUE)
tk = read.csv("../dat/teku.csv", header = TRUE)
nb = read.csv("../dat/nimbus.csv", header = TRUE)

col_lh = c("#9e0142", "#d53e4f", "#f46d43")
col_tk = c("#003c30", "#01665e", "#35978f")
col_pr = c("#40004b", "#762a83", "#9970ab")
col_nb = c("#053061", "#2166ac", "#4393c3")

pairs(lh[,c(1, 4, 6, 2, 3, 5)], main="Lighthouse", pch=".", col=alpha(col_lh[3], 0.3))
pairs(pr[,c(1, 4, 6, 2, 3, 5)], main="Prysm", pch=".", col=alpha(col_pr[3], 0.3))
pairs(nb[,c(1, 4, 6, 2, 3, 5)], main="Nimbus", pch=".", col=alpha(col_nb[3], 0.3))
pairs(tk[,c(1, 4, 6, 2, 3, 5)], main="Teku", pch=".", col=alpha(col_tk[3], 0.3))

sync <- plot(lh$time, lh$slot, main="Synchronization Progress", xlab="Unix [s]", ylab="Slot [1]", pch=".", ylim=c(0, 430000), col=alpha(col_lh[3], 0.3))
sync <- lines(pr$time, pr$slot, type="p", pch=".", col=alpha(col_pr[3], 0.3))
sync <- lines(tk$time, tk$slot, type="p", pch=".", col=alpha(col_tk[3], 0.3))
sync <- lines(nb$time, nb$slot, type="p", pch=".", col=alpha(col_nb[3], 0.3))
sync <- lines(lh$time, rollmean(lh$slot, 600, fill=list(NA, NULL, NA)), col=alpha(col_lh[2], 0.5))
sync <- lines(pr$time, rollmean(pr$slot, 600, fill=list(NA, NULL, NA)), col=alpha(col_pr[2], 0.5))
sync <- lines(tk$time, rollmean(tk$slot, 600, fill=list(NA, NULL, NA)), col=alpha(col_tk[2], 0.5))
sync <- lines(nb$time, rollmean(nb$slot, 600, fill=list(NA, NULL, NA)), col=alpha(col_nb[2], 0.5))
sync <- text(1601478000, 421000, "4h 24min", cex=0.8, pos=4, col=col_lh[1])
sync <- text(1601487000, 423000, "6h 41min", cex=0.8, pos=4, col=col_pr[1])
sync <- text(1601508000, 425000, "12h 54min", cex=0.8, pos=4, col=col_nb[1])
sync <- text(1601536000, 427000, "22h 36min", cex=0.8, pos=4, col=col_tk[1])
sync <- text(1601520000, 80000, "--- Lighthouse", cex=0.8, pos=4, col=col_lh[1])
sync <- text(1601520000, 64000, "--- Prysm", cex=0.8, pos=4, col=col_pr[1])
sync <- text(1601520000, 48000, "--- Nimbus", cex=0.8, pos=4, col=col_nb[1])
sync <- text(1601520000, 32000, "--- Teku", cex=0.8, pos=4, col=col_tk[1])

dbt <- plot(pr$time, pr$db, main="Database Size", xlab="Unix [s]", ylab="Database Size [B]", log="y", ylim=c(10000000,20000000000), pch=".", col=alpha(col_pr[3], 0.3))
# dbt <- lines(tk$time, tk$db, type="p", pch=".", col=alpha(col_tk[3], 0.3))
dbt <- lines(lh$time, lh$db, type="p", pch=".", col=alpha(col_lh[3], 0.3))
dbt <- lines(nb$time, nb$db, type="p", pch=".", col=alpha(col_nb[3], 0.3))
dbt <- lines(lh$time, rollmean(lh$db, 600, fill=list(NA, NULL, NA)), col=alpha(col_lh[2], 0.5))
dbt <- lines(pr$time, rollmean(pr$db, 600, fill=list(NA, NULL, NA)), col=alpha(col_pr[2], 0.5))
# dbt <- lines(tk$time, rollmean(tk$db, 600, fill=list(NA, NULL, NA)), col=alpha(col_tk[2], 0.5))
dbt <- lines(nb$time, rollmean(nb$db, 600, fill=list(NA, NULL, NA)), col=alpha(col_nb[2], 0.5))
dbt <- text(1601520000, 80000000, "--- Nimbus", cex=0.8, pos=4, col=col_nb[2])
dbt <- text(1601520000, 62000000, "--- Lighthouse", cex=0.8, pos=4, col=col_lh[2])
dbt <- text(1601520000, 48000000, "--- Prysm", cex=0.8, pos=4, col=col_pr[2])
dbt <- text(1601520000, 37000000, "       (Teku, missing)", cex=0.8, pos=4, col=col_tk[2])

mem <- plot(pr$time, pr$mem, main="Resident Memory", xlab="Unix [s]", ylab="Memory Usage [B]", log="y", ylim=c(100000000,20000000000), pch=".", col=alpha(col_pr[3], 0.3))
mem <- lines(tk$time, tk$mem, type="p", pch=".", col=alpha(col_tk[3], 0.3))
mem <- lines(lh$time, lh$mem, type="p", pch=".", col=alpha(col_lh[3], 0.3))
mem <- lines(nb$time, nb$mem, type="p", pch=".", col=alpha(col_nb[3], 0.3))
mem <- lines(lh$time, rollmean(lh$mem, 600, fill=list(NA, NULL, NA)), col=alpha(col_lh[2], 0.5))
mem <- lines(pr$time, rollmean(pr$mem, 600, fill=list(NA, NULL, NA)), col=alpha(col_pr[2], 0.5))
mem <- lines(tk$time, rollmean(tk$mem, 600, fill=list(NA, NULL, NA)), col=alpha(col_tk[2], 0.5))
mem <- lines(nb$time, rollmean(nb$mem, 600, fill=list(NA, NULL, NA)), col=alpha(col_nb[2], 0.5))
mem <- text(1601520000, 400000000, "--- Teku", cex=0.8, pos=4, col=col_tk[2])
mem <- text(1601520000, 336000000, "--- Prysm", cex=0.8, pos=4, col=col_pr[2])
mem <- text(1601520000, 282000000, "--- Lighthouse", cex=0.8, pos=4, col=col_lh[2])
mem <- text(1601520000, 238000000, "--- Nimbus", cex=0.8, pos=4, col=col_nb[2])

prs <- plot(tk$time, tk$peers, main="P2P Peer Count", xlab="Unix [s]", ylab="Peer Count [1]", pch=".", col=alpha(col_tk[3], 0.3))
prs <- lines(pr$time, pr$peers, type="p", pch=".", col=alpha(col_pr[3], 0.3))
prs <- lines(lh$time, lh$peers, type="p", pch=".", col=alpha(col_lh[3], 0.3))
prs <- lines(nb$time, nb$peers, type="p", pch=".", col=alpha(col_nb[3], 0.3))
prs <- lines(lh$time, rollmean(lh$peers, 600, fill=list(NA, NULL, NA)), col=alpha(col_lh[2], 0.5))
prs <- lines(pr$time, rollmean(pr$peers, 600, fill=list(NA, NULL, NA)), col=alpha(col_pr[2], 0.5))
prs <- lines(tk$time, rollmean(tk$peers, 600, fill=list(NA, NULL, NA)), col=alpha(col_tk[2], 0.5))
prs <- lines(nb$time, rollmean(nb$peers, 600, fill=list(NA, NULL, NA)), col=alpha(col_nb[2], 0.5))
prs <- text(1601520000, 15.0, "--- Teku", cex=0.8, pos=4, col=col_tk[2])
prs <- text(1601520000, 12.7, "--- Nimbus", cex=0.8, pos=4, col=col_nb[2])
prs <- text(1601520000, 10.4, "--- Lighthouse", cex=0.8, pos=4, col=col_lh[2])
prs <- text(1601520000, 8.1, "--- Prysm", cex=0.8, pos=4, col=col_pr[2])

bps <- plot(lh$time, lh$bps, main="Synchronization Speed", xlab="Unix [s]", ylab="Slots per Second [1/s]", log="y", ylim=c(1, 130), pch=".", col=alpha(col_lh[3], 0.3))
bps <- lines(pr$time, pr$bps, type="p", pch=".", col=alpha(col_pr[3], 0.3))
bps <- lines(tk$time, tk$bps, type="p", pch=".", col=alpha(col_tk[3], 0.3))
bps <- lines(nb$time, nb$bps, type="p", pch=".", col=alpha(col_nb[3], 0.3))
bps <- lines(lh$time, rollmean(lh$bps, 600, fill=list(NA, NULL, NA)), col=alpha(col_lh[2], 0.5))
bps <- lines(pr$time, rollmean(pr$bps, 600, fill=list(NA, NULL, NA)), col=alpha(col_pr[2], 0.5))
bps <- lines(tk$time, rollmean(tk$bps, 600, fill=list(NA, NULL, NA)), col=alpha(col_tk[2], 0.5))
bps <- lines(nb$time, rollmean(nb$bps, 600, fill=list(NA, NULL, NA)), col=alpha(col_nb[2], 0.5))
bps <- text(1601478000, 26, "25.934/s", cex=0.8, pos=4, col=col_lh[1])
bps <- text(1601487000, 18, "17.119/s", cex=0.8, pos=4, col=col_pr[1])
bps <- text(1601508000, 9, "8.914/s", cex=0.8, pos=4, col=col_nb[1])
bps <- text(1601536000, 6, "5.120/s", cex=0.8, pos=4, col=col_tk[1])
bps <- text(1601520000, 101, "--- Lighthouse", cex=0.8, pos=4, col=col_lh[1])
bps <- text(1601520000, 86, "--- Prysm", cex=0.8, pos=4, col=col_pr[1])
bps <- text(1601520000, 74, "--- Nimbus", cex=0.8, pos=4, col=col_nb[1])
bps <- text(1601520000, 64, "--- Teku", cex=0.8, pos=4, col=col_tk[1])

# start 1601464333  0   0   0   0   0   0   0
# light 1601480188	4811144676	2813214720	411181	51	13.6451612903226
# 4 hours 24 minutes 15 seconds (15855) 25.93383790602333648691

# prysm 1601488392	4069744640	6783991808	411862	30	8.34375
# 6 hours 40 minutes 59 seconds (24059) 17.11883286919655846045

# nimbs 1601510745	5088958968	962797568	413727	22	3.20652173913043
# 12 hours 53 minutes 32 seconds (46412) 8.91422476945617512712

# tekuh 1601545708	0	20591796224	416639	73	2.44444444444444
# 22 hours 36 minutes 15 seconds (81375) 5.11998771121351766513
