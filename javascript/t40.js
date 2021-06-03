// declaring object
const person = {
    name: 'John',
    age: 21,
}

// cloning the object
const clonePerson = Object.assign({}, person);

console.log(clonePerson);

// changing the value of clonePerson
clonePerson.name = 'Peter';

console.log(clonePerson.name);
console.log(person.name);

// program to pass a function as a parameter

function greet() {
    return 'Hello';
}

// passing function greet() as a parameter
function name(user, func)
{

    // accessing passed function
    const message = func();

    console.log(`${message} ${user}`);
}

name('John', greet);
name('Jack', greet);
name('Sara', greet);

