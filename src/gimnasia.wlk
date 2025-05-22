class Rutina {

	method caloriasQueQuema(tiempo) {
		return 100 * (tiempo - self.descanso(tiempo)) * self.intensidad()
	}

	method descanso(tiempo)

	method intensidad()

}

class Running inherits Rutina {

	const intensidad

	override method intensidad() {
		return intensidad
	}

	override method descanso(tiempo) {
		return if (tiempo > 20) {
			5
		} else {
			2
		}
	}

}

class Maraton inherits Running {

	override method caloriasQueQuema(tiempo) {
		return super(tiempo) * 2
	}

}

class Remo inherits Rutina {

	override method intensidad() {
		return 1.3
	}

	override method descanso(tiempo) {
		return tiempo / 5
	}

}

class RemoDeCompeticion inherits Remo {

	override method intensidad() {
		return 1.7
	}

	override method descanso(tiempo) {
		return (super(tiempo) - 3).max(2)
	}

}

class Persona {

	var property peso

	method hacerRutina(rutina) {
		self.validarRutina(rutina)
		peso = peso - self.pesoQuePierde(rutina)
	}

	method pesoQuePierde(rutina) {
		return self.caloriasQueGasta(rutina) / self.kilosPorCaloriaQuePierde()
	}

	// Agregado para poder manejar las calorias en el Ejercicio 3
	method caloriasQueGasta(rutina) {
		return rutina.caloriasQueQuema(self.tiempo())
	}

	method kilosPorCaloriaQuePierde()

	method validarRutina(rutina) {
		if (not self.puedeRealizar(rutina)) {
			self.error("No se puede realizar la rutina.")
		}
	}

	method tiempo()

	method puedeRealizar(rutina)

}

class Sedentario inherits Persona {

	var property tiempo

	override method kilosPorCaloriaQuePierde() {
		return 7000
	}

	override method puedeRealizar(rutina) {
		return self.peso() > 50
	}

}

class Atleta inherits Persona {

	override method tiempo() {
		return 90
	}

	override method kilosPorCaloriaQuePierde() {
		return 8000
	}

	override method puedeRealizar(rutina) {
		return rutina.caloriasQueQuema(self.tiempo()) > 10000
	}

	override method pesoQuePierde(rutina) {
		return super(rutina) - 1
	}

}

class Club {

	const predios = #{}

	method mejorPredio(persona) {
		return predios.max({ predio => predio.caloriasDelCircuito(persona) })
	}

	method prediosTranquilos(persona) {
		return predios.filter({predio => predio.esTranquilo(persona)})
	}

	method rutinasExigentes(persona){
		return predios.map({predio => predio.rutinaMasExigente(persona)}).asSet()
	}

}

class Predio {

	const rutinas = #{}

	method caloriasDelCircuito(persona) {
		return rutinas.sum({ rutina => persona.caloriasQueGasta(rutina) })
	}

	method esTranquilo(persona) {
		return rutinas.any({ rutina => persona.caloriasQueGasta(rutina) < 500 })
	}

	method rutinaMasExigente(persona){
		return rutinas.max({rutina => persona.caloriasQueGasta(rutina)})
	}

}