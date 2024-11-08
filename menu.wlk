// image = "TetrisTrainerBackground.png"
import wollok.game.*
import gameMaster.*

object pantallaActual
{
    var pantalla = menuPrincipal
    method cambiarPantalla(nuevaPantalla)
    {
        pantalla = nuevaPantalla
        game.allVisuals().forEach({visual => game.removeVisual(visual)})
        pantalla.iniciar()
    }
    method iniciar()
    {
        self.cambiarPantalla(pantalla)
    }

    method teclaSpace() {pantalla.teclaSpace()}
    method teclaShift() {pantalla.teclaShift()}
    
    method teclaRight() {pantalla.teclaRight()}
    method teclaLeft() {pantalla.teclaLeft()}
    method teclaUp() {pantalla.teclaUp()}
    method teclaDown() {pantalla.teclaDown()}
    
    method teclaC() {pantalla.teclaC()}
    method teclaX() {pantalla.teclaX()}
    method teclaZ() {pantalla.teclaZ()}

    method teclaBack() {pantalla.teclaBack()}

    method aplicarTick() {pantalla.aplicarTick()}

}

class Pantalla
{   var property image
    var property position = game.origin()
    const opciones

    method iniciar()
    {
        if(not game.hasVisual(self)) game.addVisual(self)
    }
    
    method teclaSpace() {}
    method teclaShift() {}
    
    method teclaRight() {}
    method teclaLeft() {}
    method teclaUp() {}
    method teclaDown() {}
    
    method teclaC() {}
    method teclaX() {}
    method teclaZ() {}

    method teclaBack() {}

    method aplicarTick() {}

    method aplicarGravedad() {}
}


object menuPrincipal inherits Pantalla (
    image = "menu_spr.png",
    opciones = [jugarSprint, jugarDigRace, instrucciones])
{
    var indice = 3000
    const imagenes = ["menu_spr.png", "menu_dig.png", "menu_instr.png"]
    method indice() = indice % 3
    override method image() = "TEST_" + imagenes.get(self.indice())

    override method teclaSpace() {pantallaActual.cambiarPantalla(opciones.get(self.indice()))}
    override method teclaUp() {indice -= 1}
    override method teclaDown() {indice += 1}
    
}

class PantallaJuego inherits Pantalla
{
    override method teclaSpace() {juego.ponerPieza()}
    override method teclaShift() {juego.intentarHold()}
    
    override method teclaRight() {juego.moverPieza("derecha")}
    override method teclaLeft() {juego.moverPieza("izquierda")}
    override method teclaDown() {juego.moverPieza("abajo")}

    override method teclaC() {juego.rotarPieza("derecha")}
    override method teclaX() {juego.rotarPieza("opuesto")}
    override method teclaZ() {juego.rotarPieza("izquierda")}

    override method teclaBack() {pantallaActual.cambiarPantalla(opciones.first())}

    override method aplicarTick() {juego.aplicarGravedad()}

    method modo() = null

    override method iniciar()
    {
        game.addVisual(self)
        juego.iniciarJuego(self.modo())
        if(not game.sound("music.mp3").played()) game.sound("music.mp3").shouldLoop(true) game.sound("music.mp3").play()
    }
}

object jugarSprint inherits PantallaJuego(
    image = "TEST_sprintBkg.png",
    opciones = [menuPrincipal])
{
    override method modo() = "sprint"
}
object jugarDigRace inherits PantallaJuego(
    image = "TEST_digBkg.png",
    opciones = [menuPrincipal])
{
    override method modo() = "digrace"
}
object instrucciones inherits Pantalla (
    image = "instrucciones.png",
    opciones = [menuPrincipal]
)
{
    method mostrarInstrucciones()
    {
        
    }
}
