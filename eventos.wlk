import wollok.game.*
import gameMaster.*
import numeros.*

class EventoTSpin
{
    var property position = game.at(mapa.minX() - 11, mapa.maxY() - 9)
    method image() = "eTSPIN.png"
}
class EventoBorrarLineas
{
    const lineasBorradas

    var property position = game.at(mapa.minX() - 11, mapa.maxY() - 11)
    var property image = null

    const imagenes = [null, "eSINGLE.png", "eDOUBLE.png", "eTRIPLE.png", "eQUAD.png"]

    method aplicarGravedad() {} 

    method spawn()
    {
        image = imagenes.get(lineasBorradas)
        game.addVisual(self)
        game.schedule(2500, {
            game.removeVisual(self)
            eventos.quitarEvento(self)
        })
    }
}

object eventos
{
    const eventosActuales = []
    method aplicarGravedad() {} 

    method quitarEvento(evento) = eventosActuales.remove(evento)

    method mostrarLineasBorradas(cantidad)
    {
        if(not eventosActuales.isEmpty()) eventosActuales.forEach({evento => if(game.hasVisual(evento)) game.removeVisual(evento)}) 
        const nuevoEvento = new EventoBorrarLineas(lineasBorradas = cantidad)
        eventosActuales.add(nuevoEvento)
        nuevoEvento.spawn()
        // TODO TSPIN
    }

    method aumentarContadorLineasBorradas(cantidad)
    {
        contadorLineas.aumentar(cantidad)
    }
}

object contadorLineas
{
    var property position = game.at(mapa.minX() - 1, mapa.maxY() - 13)

    var property lineasBorradas = 0

    const numeros = [
        new Numero(position = position.down(2)),
        new Numero(position = position.down(2).left(1)),
        new Numero(position = position.down(2).left(2))
    ]
    method numeros() = numeros

    method inicializar()
    {
        numeros.forEach({numero => game.addVisual(numero)})
    }

    method aumentar(cantidad) 
    {
        lineasBorradas += cantidad
        self.actualizarNumeros(numeros, cantidad)
        if(lineasBorradas > juego.targetLineasBorradas()) juego.finalizar()
    }

    method actualizarNumeros(nums, cantidad) // TODO: Continuar acá
    {
        nums.first().aumentar(cantidad)
        if(nums.size() > 1 && nums.first().huboCarry())
        {
            self.actualizarNumeros(nums.drop(1), 1)
        }
        
    }
    method aplicarGravedad() {}
}
object contadorGarbage
{
    var property position = game.at(mapa.minX() - 1, mapa.maxY() - 15)

    var property garbageBorrada = 0

    const numeros = [
        new Numero(position = position.down(2)),
        new Numero(position = position.down(2).left(1)),
        new Numero(position = position.down(2).left(2))
    ]
    method numeros() = numeros

    method inicializar()
    {
        numeros.forEach({numero => game.addVisual(numero)})
    }

    method aumentar() 
    {
        garbageBorrada += 1
        self.actualizarNumeros(numeros, 1)
        if(garbageBorrada >= juego.targetGarbageBorrada()) juego.finalizar()
    }

    method actualizarNumeros(nums, cantidad) // TODO: Continuar acá
    {
        nums.first().aumentar(cantidad)
        if(nums.size() > 1 && nums.first().huboCarry())
        {
            self.actualizarNumeros(nums.drop(1), 1)
        }
        
    }
    method aplicarGravedad() {}
}
