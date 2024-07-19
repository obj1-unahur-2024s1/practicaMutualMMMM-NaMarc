
class Actividad {
	const property idiomas = #{}
	
	method requiereEsfuerzo()
	method broncearse()
	method dias()
	method esInteresante(){
		return idiomas.size()> 1
	}
	method esRecomendadaPara(socio){
		return (self.esInteresante()and socio.leAtraeLaActividad(self) 
			and socio.actividadesQueRealizo().all({a => a!== self})) 
	}
}

class ALaPlaya inherits Actividad {
	const property longitudPlaya
	
	override method dias() {
		return longitudPlaya / 500
	}
	override method requiereEsfuerzo(){
		return longitudPlaya > 1200
	}
	override method broncearse()= true
}
class ALaCiudad inherits Actividad{
	const property cantidadExcursiones
	
	override method dias() {
		return cantidadExcursiones / 2
	}
	override method requiereEsfuerzo(){
		return cantidadExcursiones.between(5,8)
	}
	override method broncearse()= false
	
	override method esInteresante(){
		return super() or cantidadExcursiones == 5
	}
}
class ACiudadTropical inherits ALaCiudad{
	
	override method dias() {
		return super() + 1 
	}
	override method broncearse() = true
}
class SalidaDeTrekin inherits Actividad{
	const property kmSendero
	const property diasDeSolAnual
	
	
	override method dias() {
		return kmSendero / 50
	}
	override method requiereEsfuerzo(){
		return kmSendero > 80
	}
	override method broncearse(){
		return (diasDeSolAnual > 200 or diasDeSolAnual.between(100, 200)) and kmSendero > 120
	}
	override method esInteresante(){
		return super() and diasDeSolAnual > 140
	}
}
class ClasesDeGimnasia inherits Actividad {
	
	method initialize() {
		if(idiomas!=#{"español"}){
			self.error("solo se permite clase de gimnasia en español")
		}
	}
	override method dias()= 1
	override method requiereEsfuerzo()= true
	override method broncearse()= false
	
	override method esRecomendadaPara(socio){
		return socio.edad().between(20,30)
	}
}
class TallerLiterario inherits Actividad {
	const property libros = #{}
	
	method idioma(){
		return libros.map({l => l.idioma()}).asSet()
	}
	method autores(){
		return libros.map({l => l.autor()}).asSet()
	}
	override method dias()= libros.size()+ 1
	
	method libroGrande(){
		return libros.any({l => l.paginas()>500})
	}
	method mismoAutor(){
		return libros.map({l => l.autor()}).asSet().size()== 1
	}
	override method requiereEsfuerzo(){
		return (self.libroGrande()or (self.mismoAutor() and libros.size()>1))
	}
	override method broncearse()= false
	override method esRecomendadaPara(socio){
		return socio.idiomasQueHabla().size() > 1
	}
}
class Libro{
	const property idioma 
	const property paginas
	const property autor
}
