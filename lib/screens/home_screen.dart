import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController
      _tabController; // Controlador para las pestañas en la barra de navegación inferior

  @override
  void initState() {
    _tabController = TabController(
        length: 4,
        vsync: this,
        initialIndex: 0); // Inicializa el controlador con 4 pestañas
    _tabController.addListener(
        _handleTableSelection); // Escucha los cambios en la selección de pestañas
    super.initState();
  }

  _handleTableSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {}); // Redibuja la interfaz cuando se cambia la pestaña
    }
  }

  @override
  void dispose() {
    _tabController
        .dispose(); // Limpia el controlador de pestañas cuando no se usa
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900, // Color del AppBar
        elevation: 0, // Sin sombra bajo el AppBar
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  AssetImage('images/perfil.jpg'), // Imagen de perfil
              radius: 20, // Tamaño del avatar
            ),
            SizedBox(width: 10), // Espacio entre la imagen y el nombre
            Text(
              'Lorelei Leon', // Nombre de usuario
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white), // Estilo de texto del nombre
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: ImageIcon(
              AssetImage(
                  'icons/icons8-mesa-de-restaurante-64.png'), // Icono de mesa
              size: 40,
              color: Colors.black, // Color del icono
            ),
            onPressed: () {
              // Acciones al presionar el icono de la mesa
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red.shade900,
              Colors.black
            ], // Degradado de rojo a negro
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(
                  16.0), // Margen alrededor del campo de búsqueda
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar', // Texto en el campo de búsqueda
                  prefixIcon:
                      Icon(Icons.search), // Icono de lupa dentro del campo
                  filled: true,
                  fillColor: Colors.white, // Fondo blanco del campo
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20), // Borde redondeado
                    borderSide: BorderSide.none, // Sin borde visible
                  ),
                ),
              ),
            ),
            _buildCategorySection(), // Sección de categorías (Drinks, Cerveza, Snacks)
            _buildProductList(), // Lista de productos
          ],
        ),
      ),
      bottomNavigationBar: Stack(
        children: [
          BottomAppBar(
            child: TabBar(
              controller:
                  _tabController, // Controla las pestañas de navegación inferior
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'Inicio'), // Pestaña Inicio
                Tab(icon: Icon(Icons.search), text: 'Buscar'), // Pestaña Buscar
                SizedBox(width: 60), // Espacio reservado para el icono QR
                Tab(icon: Icon(Icons.local_offer), text: 'Ofertas'),
                Tab(
                    icon: Icon(Icons.shopping_cart),
                    text: 'Pedido'), // Pestaña Pedido
              ],
              indicatorColor: Colors.red.shade900, // Color del indicador activo
              labelColor:
                  Colors.red.shade900, // Color de la pestaña seleccionada
              unselectedLabelColor:
                  Colors.grey, // Color de las pestañas no seleccionadas
            ),
          ),
          Positioned(
            bottom: 25, // Para que el QR esté por encima de la barra inferior
            left: MediaQuery.of(context).size.width / 2 -
                30, // Centra el icono QR
            child: FloatingActionButton(
              backgroundColor:
                  Colors.amber, // Color de fondo para resaltar el QR
              onPressed: () {
                // Acción para escanear el código QR
              },
              child: Icon(Icons.qr_code_scanner,
                  size: 40, color: Colors.black), // Icono QR
            ),
          ),
        ],
      ),
    );
  }

  // Sección de categorías de productos
  Widget _buildCategorySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 10.0), // Margen alrededor de las categorías
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround, // Espacio uniforme entre los iconos
        children: [
          _buildCategoryItem(
              'Drinks', Icons.local_drink, Colors.pink), // Categoría "Drinks"
          _buildCategoryItem(
              'Cerveza', Icons.local_bar, Colors.amber), // Categoría "Cerveza"
          _buildCategoryItem(
              'Snacks', Icons.fastfood, Colors.orange), // Categoría "Snacks"
        ],
      ),
    );
  }

  // Widget para un ítem de categoría (icono + texto)
  Widget _buildCategoryItem(String label, IconData icon, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30, // Tamaño del círculo
          backgroundColor: Colors.white, // Fondo blanco del círculo
          child: Icon(icon, color: color, size: 30), // Icono dentro del círculo
        ),
        SizedBox(height: 5), // Espacio entre el icono y el texto
        Text(
          label, // Nombre de la categoría (Drinks, Cerveza, Snacks)
          style:
              TextStyle(color: Colors.white), // Estilo del texto de categoría
        ),
      ],
    );
  }

  // Lista de productos
  Widget _buildProductList() {
    return Expanded(
      // La lista ocupará todo el espacio disponible
      child: ListView(
        padding: EdgeInsets.all(16.0), // Margen alrededor de los productos
        children: [
          _buildProductCard(
              'Bebidas', '22.85', 'images/bebidas.jpg'), // Producto 1:
          _buildProductCard(
              'Alitas', '50.65', 'images/alitas.jpg'), // Producto 2:
          _buildProductCard(
              'Snacks', '30.55', 'images/snacks.jpg'), // Producto 3:
        ],
      ),
    );
  }

  // Tarjeta de un producto individual
  Widget _buildProductCard(String title, String price, String imagePath) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0), // Espacio entre tarjetas
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)), // Bordes redondeados
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alineación del contenido a la izquierda
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(
                  15.0), // Bordes redondeados solo en la parte superior
            ),
            child: Image.asset(
              imagePath, // Imagen del producto
              fit: BoxFit
                  .cover, // Ajusta la imagen para que cubra todo el espacio
              width: double.infinity, // Ocupa todo el ancho disponible
              height: 150, // Altura de la imagen
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
                10.0), // Espacio interno alrededor del texto
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Texto y precio a los lados opuestos
              children: [
                Text(
                  title, // Nombre del producto
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold, // Texto en negrita
                  ),
                ),
                Text(
                  '\$$price', // Precio del producto
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900, // Color del texto del precio
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
