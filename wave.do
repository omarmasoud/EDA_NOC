onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /routertest/di1
add wave -noupdate /routertest/di2
add wave -noupdate /routertest/di3
add wave -noupdate /routertest/di4
add wave -noupdate /routertest/do1
add wave -noupdate /routertest/do2
add wave -noupdate /routertest/do3
add wave -noupdate /routertest/do4
add wave -noupdate /routertest/w1
add wave -noupdate /routertest/w2
add wave -noupdate /routertest/w3
add wave -noupdate /routertest/w4
add wave -noupdate /routertest/rst
add wave -noupdate /routertest/wclk
add wave -noupdate /routertest/rclk
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {28 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {2 ns} {30 ns}
