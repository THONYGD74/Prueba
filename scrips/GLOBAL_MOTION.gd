extends Node

func move(inicio: int, final: int, progreso: int):
	if inicio < final:
		return min(inicio + progreso, final)
	else:
		return max(inicio - progreso, final)
		
