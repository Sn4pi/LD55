instance_create_layer(room_width / 2, room_height, "Instances", oSystem);

globalvar parsys, parem;
parsys = part_system_create();
part_system_depth(parsys, 0);
parem = part_emitter_create(parsys);

room_goto_next();