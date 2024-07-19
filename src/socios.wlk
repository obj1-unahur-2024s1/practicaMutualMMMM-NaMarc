import actividades.*

class Socios {
	const property actividadesQueRealizo = []
	const property maxActividades
	const property idiomasQueHabla = #{}
	const property edad
	
	 
	method esAdoradorDelSol(){
		return actividadesQueRealizo.all({a => a.broncearse()})
	}
	method actividadesConEsfuerzo(){
		return actividadesQueRealizo.map({a => a.requiereEsfuerzo()})
	}
	method realizarActividad(actividad){
		if (actividadesQueRealizo.size() == maxActividades)
		self.error("Ya no puede realizar más actividades")
		else actividadesQueRealizo.add(actividad)
	}
	method leAtraeLaActividad(actividad)
}
class Tranquilo inherits Socios{
	override method leAtraeLaActividad(actividad){
		return actividad.dias()> 4
	}
}
class Coherente inherits Socios{
	override method leAtraeLaActividad(actividad){
		return if (self.esAdoradorDelSol())actividad.broncearse()
		else actividad.requiereEsfuerzo()
	}
}
class Relajado inherits Socios{
	override method leAtraeLaActividad(actividad){
		return idiomasQueHabla.intersection(actividad.idiomas()).size() >= 1
	}
}
