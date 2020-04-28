# Needed only by IceCat and Firefox

oom_score_adj_allow_write() {
	addpredict /proc/self/oom_score_adj
}
