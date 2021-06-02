// program to clone the object

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


// program to clone the object
// declaring object
const person = {
    name: 'John',
    age: 21,
}

// cloning the object
const clonePerson = { ... person}

console.log(clonePerson);

// changing the value of clonePerson
clonePerson.name = 'Peter';

console.log(clonePerson.name);
console.log(person.name);

const person = {
    name: 'John',
    age: 21,

    // the inner objects will change in the shallow copy
    marks: { math: 66, english: 73}
}

// cloning the object
const clonePerson = { ... person}

console.log(clonePerson); // {name: "John", age: 21, marks: {…}}

// changing the value of clonePerson
clonePerson.marks.math = 100;

console.log(clonePerson.marks.math); // 100
console.log(person.marks.math); // 100