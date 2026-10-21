@{
    # SC2302 is Markdown-authored, one chapter per lecture group. build.ps1
    # reads the Markdown and emits one HTML page per topic.
    Topics = @(
        @{ Source = '1.md'
           Title  = 'Classes, Objects and Encapsulation' }
        @{ Source = '2.md'
           Title  = 'Inheritance, Overriding and Visibility' }
        @{ Source = '3.md'
           Title  = 'Interfaces and Scanner Input' }
        @{ Source = '4.md'
           Title  = 'Polymorphism, Binding and Typecasting' }
        @{ Source = '5.md'
           Title  = 'Exception Handling and File I/O' }
        @{ Source = '6.md'
           Title  = 'UML Class Diagrams and Class Relationships' }
        @{ Source = '7.md'
           Title  = 'Sequence Diagrams and Modelling an OO Application' }
        @{ Source = '8.md'
           Title  = 'Design Principles and SOLID' }
        @{ Source = '9.md'
           Title  = 'Modern Java: Generics, Collections, Lambdas, Streams and Switch' }
    )

    # Earlier topic builds are replaced by the chapters above.
    Obsolete = @(
        'practice.html',
        '1-object-oriented-modelling\1.html',
        '2-classes-and-objects\2.html',
        '3-inheritance\3.html',
        '5-polymorphism-and-typecasting\5.html',
        'test-1\test-1.html',
        'test-2\test-2.html',
        'test-3\test-3.html',
        'test-4\test-4.html'
    )
}
