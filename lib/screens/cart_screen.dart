import 'package:flutter/material.dart';
import 'product_detail_screen.dart';
import '../providers/cart_items_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = CartItemsProvider.of(context);
    final finalList= provider.cart;

    _buildProductQuantity(IconData icon,int index){
      return GestureDetector(
        onTap: (){
          setState(() {
            icon == Icons.add?provider.incrementQuantity(index):provider.decrementQuantity(index);
          });
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red.shade100,
          ),
          child: Icon(icon,size: 13.5,),
        ),
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: ListView.builder(itemCount: finalList.length,
            itemBuilder:(context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
              onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: finalList[index]),
              ),
              );
              },


                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(onPressed: (context){
                          finalList.removeAt(index);
                          setState(() {

                          });
                        },backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',),
                      ],
                    ),
                    child: ListTile(
                    
                      title: Text(
                        finalList[index].title,style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      subtitle: Text(
                        '\$${finalList[index].price}',
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(finalList[index].imageUrl),
                        backgroundColor: Colors.red.shade100,
                      ),
                      trailing: Column(
                        children:[
                          _buildProductQuantity(Icons.add, index),
                          Text(
                        '${finalList[index].quantity}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                        _buildProductQuantity(Icons.remove, index),
                        ],),
                      tileColor: Colors.white,
                    ),
                  ),
                ),);

            }
            ,),),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            width: double.infinity,
            height: 100,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${provider.getTotalPrice()}',
                style: const TextStyle(
                  fontSize: 40,fontWeight: FontWeight.bold,
                ),),
                ElevatedButton.icon(
                    onPressed: (){
                      
                    }, icon: const Icon(Icons.send),
                label: const Text('Check out'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),)
                
              ],
            )
          )

        ],
      ),
    );
  }
}
