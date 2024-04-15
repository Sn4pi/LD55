instance_create_layer(room_width / 2, room_height, "Instances", oSystem);
instance_create_layer(0, 0, "Instances", oMusic);

globalvar parsys, parem;
parsys = part_system_create();
part_system_depth(parsys, 0);
parem = part_emitter_create(parsys);

globalvar wealth, wealthX, wealthY;
wealth = 0;
wealthX = -1;
wealthY = -1;

room_goto_next();