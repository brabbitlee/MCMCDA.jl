
println("Testing proposal moves...")
srand(1)
# for i in 1:100
# 	v = vertices(blips.graph)[i]
# 	if ! in_track(v, blips) && out_degree(v, blips.graph) > 0
# 		println(i)
# 		break
# 	end
# end

va = vertices(blips.graph)[10]
e = out_edges(va, blips.graph)[1]
n1 = n_tracks_started(blips)

extend!(va, blips, 0)
@assert n_tracks_started(blips) == n1 + 1

@assert e.attributes["active"]
@assert e.attributes["proposed"]
@assert n_proposed(blips) > 0

reject_move!(blips)
@assert ! e.attributes["active"]
@assert n_proposed(blips) == 0
@assert e.attributes["freq_inactive"] == 1

extend!(va, blips, 0)
@assert e.attributes["active"]
@assert e.attributes["proposed"]

accept_move!(blips)
@assert n_proposed(blips) == 0
@assert e.attributes["active"]
@assert e.attributes["freq_active"] == 1

propose_birth!(blips, 0) # first is a misfire with this random seed
propose_birth!(blips, 0)
accept_move!(blips)

n1 = n_tracks_started(blips)
propose_death!(blips)
@assert n_tracks_started(blips) == n1 - 1

accept_move!(blips)

# propose_move!(blips, 1, blips.nscans)