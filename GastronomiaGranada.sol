// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GastronomiaGranada
 * @dev Registro historico con Likes, Dislikes e Identificador de Especia Reina.
 * Nota: Codigo ASCII puro para evitar errores de compilacion.
 */
contract GastronomiaGranada {

    struct Plato {
        string nombre;
        string descripcion;
        string especiaReina; // Ej: Nuez Moscada, Canela, Clavo, Pimienta
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public menuHistorico;
    uint256 public totalPlatos;

    constructor() {
        // Inauguramos con el Oil Down
        registrarPlato(
            "Oil Down", 
            "Guiso de una sola olla con fruta del pan, leche de coco, carne salada y especias.",
            "Nuez Moscada"
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _descripcion, 
        string memory _especiaReina
    ) public {
        require(bytes(_nombre).length + bytes(_descripcion).length <= 200, "Texto demasiado largo");
        
        totalPlatos++;
        menuHistorico[totalPlatos] = Plato({
            nombre: _nombre, 
            descripcion: _descripcion,
            especiaReina: _especiaReina,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre, 
        string memory descripcion, 
        string memory especiaReina,
        uint256 likes, 
        uint256 dislikes
    ) {
        require(_id > 0 && _id <= totalPlatos, "ID invalido.");
        Plato storage p = menuHistorico[_id];
        return (p.nombre, p.descripcion, p.especiaReina, p.likes, p.dislikes);
    }
}
