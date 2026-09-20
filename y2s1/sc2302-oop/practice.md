Done — full transcription below (skipped poll percentages, just questions + marked-correct answers).

---

# wooclap Questions

## Chapter 2: Class and Object
- "Based on your understanding, Schoolbag is a/an…" → Class (points to Schoolbag in general)
- "Based on your understanding, Schoolbag Justin is carrying, is a/an…" → Object (a particular schoolbag)

## Week 4
Q1

public class StringDemo {
    public static void main(String args[]) {
        char chars[] = {'J','O','V'};
        String s = new String(chars);
        String s1 = "12345";
        char c = s1.charAt(2);
        int len1 = s.length();
        System.out.println(c + " " + len1);
    }
}

→ `3 3`

Q2 (TestString: `i=10; j=i; str="Java"; str2=str; i=1003; str="I love Java"; println(str2+j)`)
→ `Java10`
- int is primitive → copied by value, not reference
- Strings are immutable → reassigning changes the reference, not the object

## Studocu — Introduction to Object Oriented Design
Q1 Which statement(s) describe the student–tutorial group relationship correctly?
→ "A tutorial group has a student/students" and "A student is a part of a tutorial group"

Q2 Relationship between a person's hands and the person?
→ Has-A / Composition (NOT aggregation)

Q3 Relationship between can drinks and a vending machine?
→ Has-A / Aggregation (not composition — a vending machine can operate without can drinks, unless it's a can-drink vending machine)

Q4 Errors in the class diagram (Teacher / iManager / iCoordiantor / AbstractTE)?
→ Abstract class cannot implement interface and Interface cannot extend interface

Q5 class A { private C c; public void myMethod(B b){ b.callMethod(); } }
→ II and III (A–C is Association, A–B is Dependency)

---

# Additional Practice Questions

## Chapters 1–3
Q class B extends A { public B(){ super(); this(5); } … } — what happens?
→ D) Compilation error in class B — you can't have 2 constructor calls in one constructor body

Q class Child extends Parent where Parent only has Parent(int value), Child has no-arg constructor
→ Compilation error in class Child — no no-arg constructor in the parent class

Q Shape/Square, Shape s = new Square();
→ B)

Shape constructor, area = 0
Shape constructor, area = 16

*(page literally writes "Shape" twice — second line should read "Square constructor")*
1. Memory allocated, all fields 0 → shape x = 0, square x = 0
2. Shape constructor runs: shape x = 1, but overriding (runtime polymorphism) calls Square.area(), square x still 0 → 0*0
3. After Shape constructor: square x = 4, Square constructor calls area() → 4*4 = 16

Q Library system design (A/B/C/D) — which best follows encapsulation, clear responsibilities, scalability?
→ Design C — Class Loan can be a loan list of students stored as an array of lists, accessed through getters

Q Box b1/b2/b3, b3 = b1; b2 = b3; b2.volume = 40;
→ 40 40 40 — b3 = b1, b2 = b3, so all three reference the same object

Q Person/Student inheritance, new Student("Alex", 2)
→ B) Person constructor: Alex then Student constructor: 2 — this is method refinement

Q Mobile banking app — best choice for a class?
→ C) A general blueprint representing a bank account with attributes and behaviors — the others are states/UI elements, not classes. You'd need a BankAccount class for behaviours like withdraw, deposit etc.

Q class A { int x=1; print(){...} } class B extends A { int x=2; print(){...} }, A obj = new B(); println(obj.x); obj.print();
→ C) 1 then B: 2 — fields are resolved statically, methods dynamically. *(Notion left this toggle blank)*

---

# Wooclap polls (marked-correct answers)
| Question | Correct answer |
|---|---|
| Purpose of abstraction at class level | To hide complexity and expose only essential features |
| Anonymous class + lambda output | Hello from anonymous Hello from lambda |
| Boundary class represents | Interface with user |
| Animal/Dog a.sound() output | Dog speaks Animal plays with Animal |
| class Student { calculateAverage, getHighestScore, getLowestScore, isPassed } — SRP? | Does NOT violate SRP because all methods change for the same reason |
| Complete public static ____ getFirst(____ arr) { return arr[0]; } | `<T> T, T[]` |
| Runtime polymorphism (method overriding) — select all | Happens at runtime, Same interface, different behavior, Uses inheritance |
| Student/Course: which are TRUE | Relationship is Aggregation, Course HAS-A Student, Student HAS-A Course |
| list.stream().filter(len>1).map(toUpperCase).forEach(print) on ["a","bb","ccc"] | BBCCC |
| Payment system adding PayNow/PayPal by modifying existing code | OCP |
| try{A; 10/0; B} catch{C} finally{D} then E | A C D E |
| Restaurant system directly uses HPPrinter | Violates DIP |
| Animal/Dog a.bark() where a is new Animal() w/ instanceof check | Not a Dog |
| "User books a ride (Grab/TADA)" — Control object | RideController |
| PaymentService receives CreditCard as method parameter, doesn't store it | Dependency (USE-A) |
| Team has many Players, players exist independently | Aggregation |
| Animal a = new Dog(); a.makeSound(); //L2  a.bark(); //L3 | Compilation error at Line 3 |
| Game system entity classes | Player, Match, Result |
| class Test implements A, B both with default void show() | Compilation error |
| Person p = new Person(); p.sayHello(); //L1  p.sayHi(); //L2 (static interface method) | Compilation error at Line 2 — static interface methods aren't inherited |

Sources: [wooclap Questions | Notion](https://app.notion.com/p/wooclap-Questions-2fcbbf42e099803b9c20e27ad729737e)