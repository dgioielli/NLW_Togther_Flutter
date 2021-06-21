

void main(){
    //print("Hello World!");
    printaMessage( msg:"Hello World!");
    // Não é necessário usar o new
    var classe = MinhaClass();
    printaMessage(msg: classe.message);
}

//void printaMessage({var msg}){
//void printaMessage({String? msg}){
//void printaMessage({required String msg}){
void printaMessage({required String msg}){
    print(msg);
}


// class NomeDaClass{}

class MinhaClass{
    var message = "Deu certo";
}