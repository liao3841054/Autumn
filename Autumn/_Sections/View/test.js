var factorial = function(n) {
    if (n < 0)
        return;
    if (n === 0)
        return 1;
    return n * factorial(n - 1)
};


var hello = function(message) {
    return "Hello " + message;
}

var hola = function(name) {
    return "Hola " + name + " Cómo estás?";
}