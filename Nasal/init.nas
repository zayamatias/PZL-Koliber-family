# Copyright SP-NTX 2022
# based on acconfig by Octal450

var progress = maketimer(0.5, func {
	var progress = getprop("init//progress");
	if (progress == 0) {
		setprop("init/state", ".");
		setprop("init/progress", 1);
	} else if (progress == 1) {
		setprop("init/state", "..");
		setprop("init/progress", 2);
	} else if (progress == 2) {
		setprop("init/state", "...");
		setprop("init/progress", 3);
	} else if (progress == 3) {
		setprop("init/state", "....");
		setprop("init/progress", 4);
	} else if (progress == 4) {
		setprop("init/state", ".....");
		setprop("init/progress", 0);
	}
	
});
var init_progress = gui.Dialog.new("sim/gui/dialogs/init/init/dialog", "Aircraft/PZL-Koliber-family/Init/ac_init.xml");
progress.start();
init_progress.open();

setlistener("sim/signals/fdm-initialized", func {
	init_progress.close();
	progress.stop();
});

setlistener("instrumentation/comm[0]/volume", func(node) {
	if (node.getValue() >0){
		setprop("instrumentation/comm[0]/power-btn",1);
		setprop("instrumentation/comm[0]/operable",1);
		setprop("systems/electrical/outputs/comm[0]",1);
	}else{
		setprop("instrumentation/comm[0]/power-btn",0);
		setprop("instrumentation/comm[0]/operable",0);
	}
	progress.stop();
});
