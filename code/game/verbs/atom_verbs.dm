/atom/movable/verb/pull()
	set name = "Pull"
	set category = "Object"
	set src in oview(1)

	if(Adjacent(usr))
		usr.start_pulling(src)
	return

/atom/verb/point()
	set name = "Point To"
	set category = "Object"
	set src in oview()
	var/atom/this = src//detach proc from src
	src = null

	if(!usr || !isturf(usr.loc))
		return
	if(usr.stat || usr.restrained())
		return
	if(usr.status_flags & FAKEDEATH)
		return

	var/tile = get_turf(this)
	if (!tile)
		return

	var/P = new /obj/effect/decal/point(tile)
	spawn (20)
		if(P)	del(P)

	usr.visible_message("<b>[usr]</b> points to [this]")

	for(var/mob/living/simple_animal/smart_animal/SA in view(7))
		SA.target_point(this, usr)