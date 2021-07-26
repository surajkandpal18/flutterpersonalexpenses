import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function deleteTransaction;
  TransactionList(this.userTransaction, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return userTransaction.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'No Transactions added yet!!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(9),
                      child: FittedBox(
                        child: Text('₹ ${userTransaction[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    userTransaction[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(userTransaction[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? FlatButton.icon(
                          onPressed: () {
                            deleteTransaction(userTransaction[index].id);
                          },
                          textColor: Colors.red,
                          icon: Icon(Icons.delete),
                          label: Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ))
                      : IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deleteTransaction(userTransaction[index].id);
                          },
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
            itemCount: userTransaction.length,
          );
  }
}
