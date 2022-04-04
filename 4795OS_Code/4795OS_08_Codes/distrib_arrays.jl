# before running this code:
# start a Julia REPL with: julia -p N with N > 4 
# Otherwise you get a BoundsError in the call workers()[1:4]
arr = drand((100,100), workers()[1:4], [1,4])
# 100x100 DArray{Float64,2,Array{Float64,2}}:
#  0.815847   0.354301   0.212216   …  0.649562   0.0508848  0.803529
#  0.214374   0.132324   0.500233      0.147626   0.887912   0.0595262
#  0.396211   0.77957    0.290449      0.856027   0.558378   0.635368
#  0.398797   0.924516   0.473312      0.754448   0.310684   0.214169
#  0.472551   0.291316   0.166627      0.358318   0.711451   0.0217645
#  0.211057   0.0705473  0.0590814  …  0.981098   0.834826   0.289676
#  0.457238   0.666109   0.505208      0.173396   0.589662   0.0842167
#  0.2103     0.793901   0.0772641     0.600755   0.511281   0.482069
#  0.0666974  0.271477   0.47484       0.344734   0.400214   0.529893
#  0.0929895  0.334918   0.317601      0.0641198  0.93372    0.119353
#  ⋮                                ⋱
#  0.480727   0.205939   0.510688   …  0.472838   0.293027   0.7352
#  0.146304   0.431916   0.386177      0.441221   0.750997   0.126209
#  0.454018   0.935533   0.369919      0.483729   0.832018   0.369996
#  0.374881   0.542864   0.642512      0.781415   0.903669   0.669261
#  0.181886   0.602693   0.50041       0.750187   0.553714   0.43828
#  0.699433   0.904601   0.351032   …  0.764433   0.0109924  0.110523
#  0.95344    0.693372   0.25179       0.965437   0.0590245  0.698218
#  0.518332   0.241622   0.476134      0.201053   0.253833   0.882931
#  0.183282   0.134111   0.40739       0.184264   0.104197   0.795514
#  0.539012   0.453164   0.0306549     0.926738   0.326411   0.284542

arr.dims # (100, 100)
arr.pmap # on which workers ? 4-element Array{Int64,1}: 2 3 4 5
arr.indexes # data division:
# 1x4 Array{(UnitRange{Int64},UnitRange{Int64}),2}:
#  (1:100,1:25)  (1:100,26:50)  (1:100,51:75)  (1:100,76:100)
arr.cuts # data division:
# 2-element Array{Array{Int64,1},1}:
#  [1,101]
#  [1,26,51,76,101]
arr.chunks # references on the workers:
# 1x4 Array{RemoteRef,2}:
#  RemoteRef(2,1,11164)  RemoteRef(3,1,11165)  …  RemoteRef(5,1,11167)

da = @parallel [2i for i = 1:10]
# 10-element DArray{Int64,1,Array{Int64,1}}:
#   2
#   4
#   6
#   8
#  10
#  12
#  14
#  16
#  18
#  20

DArray((10,10)) do I
    println(I)
    return zeros(length(I[1]),length(I[2]))
end
#         From worker 2:  (1:5,1:3)
#         From worker 8:  (1:5,9:10)
#         From worker 4:  (1:5,4:5)
#         From worker 3:  (6:10,1:3)
#         From worker 5:  (6:10,4:5)
#         From worker 7:  (6:10,6:8)
#         From worker 6:  (1:5,6:8)
#         From worker 9:  (6:10,9:10)
# 10x10 DArray{Float64,2,Array{Float64,2}}:
#  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
#  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
#  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
#  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
#  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
#  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
#  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
#  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
#  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0
#  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0