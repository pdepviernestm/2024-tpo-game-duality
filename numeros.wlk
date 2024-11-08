
class Numero
{
    var carry = false
    var property position
    var property num = 0
    var property image = imagenes.get(0)

    method aplicarGravedad() {}


    const imagenes = [
        "nCERO.png",
        "nUNO.png",
        "nDOS.png",
        "nTRES.png",
        "nCUATRO.png",
        "nCINCO.png",
        "nSEIS.png",
        "nSIETE.png",
        "nOCHO.png",
        "nNUEVE.png"]
        
    method huboCarry() = carry
    method aumentar(cantidad) {self.cambiarNumero(num + cantidad)}
    method cambiarNumero(nuevoNum)
    {
        if(nuevoNum > 9) 
        {
            num = nuevoNum - 10
            carry = true
        }
        else
        {
            num = nuevoNum
            carry = false
        }
        image = imagenes.get(num)
    }
}
