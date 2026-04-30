# 程序设计原则

## SOLID 原则

### 1. 单一职责原则（SRP：Single Responsibility Principle）

一个类或模块应该只包含单一的职责，有且只有一个原因使其变更。

如果一个类或模块承担了过多的职责，那么它将变得难以维护和修改。例如，一个负责展示用户信息的组件不应该同时负责处理用户信息的逻辑，因为这两个职责是不同的。

### 2. 开闭原则（OCP：Open Closed Principle）

实体（类、模块、函数等）应该对扩展是开放的，对修改是封闭的。即可扩展(extension)，不可修改(modification)。

也就是说，当需要改变一个软件实体的行为时，应该尽量通过扩展来实现，而不是通过修改原有的代码。

> 不同用户类型进行不同服务，但是后续每新增不同的用户类型，只能在下面继续加判断代码。
> 
> 
> ```java
> class VIPCenter {
>   public serviceVIP(user: User) {
>     if(user.getType() === "TrialVIP") {
>       // 活动赠送 VIP
>       // do something
>     } else if (user.getType() === "RealVIP") {
>       // do something
>     }
>   }
>   // ...
> }
> ```
> 
> 修改后代码，用户实现统一的接口，后续新增用户类型，只需要新增对应实现类。
> 
> ```java
> class VIPCenter {
>   private providers = new Map<USER_TYPE, ServiceProvider>;
> 
>   public serviceVIP(user: User) {
>     providers.get(user.getType()).service(user);
>   }
> }
> 
> interface ServiceProvider {
>   public service(user: User);
> }
> 
> class TrialVIPServiceProvider implements ServiceProvider {
>   public service(user: User) {
>     // do something
>   }
> }
> 
> class RealVIPServiceProvider implements ServiceProvider {
>   public service(user: User) {
>     // do something
>   }
> }
> ```
> 

### 3. 里氏替换原则（LSP：Liskov Substitution Principle）

一个对象在其出现的任何地方，都可以用子类实例做替换，并且不会导致程序的错误。

也就是说，任何基类可以出现的地方，子类一定可以出现，而且保证不会出错或导致异常。

```tsx
class Animal {
  move() {
    console.log('Animal is moving');
  }
}

class Dog extends Animal {
  move() {
    console.log('Dog is running');
  }
}

function moveAnimal(animal: Animal) {
  animal.move();
}
```

在上面的代码中，Animal 类定义了一个 move 方法，它的子类 Dog 重写了这个方法。moveAnimal 函数接受一个 Animal 类型的参数，并调用它的 move 方法。由于 Dog 是 Animal 的子类，所以它可以作为参数传递给 moveAnimal 函数，而不会导致异常。

### 4. 接口隔离原则（ISP：Interface Segregation Principle）

接口隔离原则表明客户端不应该被强迫实现一些他们不会使用的接口，应该把胖接口中的方法分组，然后用多个接口替代它，每个接口服务于一个子模块。

简单地说，就是使用多个专门的接口比使用单个接口要好很多。

ISP的主要观点如下：

1. 一个类对另外一个类的依赖性应当是建立在最小的接口上的。
    
    ISP可以达到不强迫客户（接口的使用方法）依赖于他们不用的方法，接口的实现类应该只呈现为单一职责的角色（遵循SRP原则）
    
    ISP还可以降低客户之间的相互影响---当某个客户要求提供新的职责（需要变化）而迫使接口发生改变时，影响到其他客户程序的可能性最小。
    
2. 客户端程序不应该依赖它不需要的接口方法（功能）。
    
    客户端程序就应该依赖于它不需要的接口方法（功能），那依赖于什么？依赖它所需要的接口。客户端需要什么接口就是提供什么接口，把不需要的接口剔除，这就要求对接口进行细化，保证其纯洁性。
    

### 5. 依赖倒置原则（DIP：Dependence Inversion Principle）

高层模块不应该依赖于低层模块，它们应该依赖于抽象。抽象不应该依赖于具体实现，具体实现应该依赖于抽象。

`开闭原则(OCP)`是面向对象设计原则的基础也是整个设计的一个终极目标，而`依赖倒置原则(DIP)`则是实现OCP原则的一个基础，换句话说`开闭原则(OCP)`是你盖一栋大楼的设计蓝图，那么`依赖倒置原则(DIP)`则就是盖这栋大楼的一个钢构框架。

## 合成复用原则（Composite/Aggregate Reuse Principle）

合成复用原则是一种面向对象设计原则，它强调在软件设计中应该尽量使用合成/聚合的方式来实现代码的复用，而不是通过继承来实现。

具体来说，合成复用原则要求程序员尽量使用对象组合、聚合等方式来构建对象之间的关系，而不是通过继承来实现代码的复用。通过将现有对象组合在一起或者将对象作为成员变量，来构建新的对象，从而实现代码的复用。

合成复用原则的优点在于：

1. 可以减少代码的耦合度，降低系统的复杂性，提高系统的可维护性和可扩展性。
2. 可以避免继承带来的代码复杂性和不必要的设计限制。
3. 可以提高代码的灵活性和可重用性，使得系统更加易于维护和扩展。

合成复用原则的实现可以通过以下几种方式：

1. 使用对象组合的方式来构建新的对象，将现有对象组合在一起，构建出更加复杂的对象。
2. 使用聚合的方式来构建新的对象，将现有对象作为成员变量，构建出更加复杂的对象。
3. 使用工厂模式来创建对象，使用抽象工厂模式、简单工厂模式等工厂模式，将对象的创建和使用分离开来，提高代码的灵活性和可复用性。

合成复用原则可以帮助程序员设计出具有低耦合度、高内聚性的软件系统，提高系统的可维护性和可扩展性。同时，也是面向对象设计中重要的原则之一。

## 迪米特法则（Law of Demeter）

迪米特法则，又称最少知道原则是一种软件设计原则，它强调一个对象不应该知道太多关于其他对象的信息，只和它直接的朋友交流，避免与非直接朋友的耦合。

具体来说，迪米特法则要求一个对象对其他对象的依赖关系应该建立在最小的接口上，也就是说，应该尽量减少对象之间的交互，让对象之间的关系尽可能简单，降低耦合度，提高模块化和可维护性。

迪米特法则的实现可以通过以下几种方式：

1. 只与直接的朋友通信，即只与与自己相互交互的对象进行交互，不与非直接朋友交互。
2. 将对象的依赖关系尽可能地隐藏在对象内部，对外部对象提供尽可能少的接口。
3. 将复杂的对象分解成多个简单的对象，每个对象只负责一个简单的任务，降低对象之间的耦合度。

迪米特法则可以帮助程序员设计出具有低耦合度、高内聚性的软件系统，提高系统的可维护性和可扩展性。同时，它也是面向对象设计中重要的原则之一。

## 奥卡姆剃刀原则

奥卡姆剃刀原则（Occam's Razor）是一种用于思考和决策的原则，它最初是由威廉·奥卡姆提出的，他认为复杂的解释往往会引入不必要的复杂性和混乱，因此最好选择简单的解释。在程序设计中，奥卡姆剃刀原则可以被理解为：在多种解释或方案中，应该选择最简单、最直接、最有效的那个。

在程序设计中，奥卡姆剃刀原则的应用可以有以下几个方面：

1. 简化代码：在编写代码时，应该尽可能地简化代码，避免不必要的复杂性和冗余代码。简单的代码更易于理解、维护和扩展。
2. 选择最简单的数据结构和算法：在选择数据结构和算法时，应该尽可能地选择最简单、最直接、最有效的那个。这样可以减少代码的复杂性和运行时间的开销。
3. 避免过度设计：在设计程序架构时，应该避免过度设计和过度抽象。应该根据实际需求和项目规模，选择最简单、最直接、最有效的架构方案。
4. 简化用户界面：在设计用户界面时，应该尽可能地简化界面，避免不必要的复杂性和冗余功能。简单的界面更易于使用和理解。

总之，奥卡姆剃刀原则的核心思想是要尽可能地简化问题、简化解决方案，选择最直接、最有效的方式来解决问题。在程序设计中，遵循奥卡姆剃刀原则可以帮助我们编写出简单、易于维护和扩展的代码，提高代码的质量和效率。

## KISS（**K**eep **I**t **S**imple, **S**tupid）

KISS 原则强调在设计和编写代码时，应该选择最简单的解决方案，避免过度设计和复杂性。

KISS原则的核心思想是：保持代码简单易懂、易维护、易扩展。具体来说，可以通过以下几种方式来实现 KISS原则：

1. 简化代码结构：尽可能减少代码中的嵌套、循环和条件判断，使代码更加清晰和易于理解。
2. 避免过度设计：在设计和编写代码时，不要过度设计和引入不必要的功能，只关注最基本的需求。
3. 保持代码简洁：尽可能使用简单的语言和代码结构，避免使用复杂的算法和数据结构，避免使用过多的注释和命名，使代码易于阅读和理解。
4. 充分利用通用模块：在实现某个功能时，尽可能使用已有的通用模块和库，避免重复造轮子，使代码更加简洁和易于维护。

KISS原则的实现可以帮助程序员避免代码过于复杂和难以理解，提高代码的可读性、可维护性和可扩展性。同时，KISS原则也有助于降低开发和维护成本，提高开发效率。

需要注意的是，KISS原则并不是一种绝对的原则，有时为了实现其他的设计目标，如性能优化或代码可读性，可能需要违反 KISS原则。在实际编写代码时，需要综合考虑多个因素，找到最合适的平衡点。

与奥卡姆剃刀原则相比，KISS原则更加注重代码的实现，而奥卡姆剃刀原则更加注重问题的解释。KISS原则和奥卡姆剃刀原则都强调简单和简洁，但强调的方面略有不同。在实际编写代码时，可以根据具体情况选择使用这些原则的不同方面，以达到更好的设计效果。

## YAGNI（You Aren't Gonna Need It）

YAGNI原则是一种软件设计原则，它强调在软件开发过程中不要实现不必要的功能，避免过度设计和开发。

具体来说，YAGNI原则要求程序员只实现当前需要的功能，而不要预先实现未来可能需要的功能，避免过度设计和浪费时间。程序员应该专注于当前需求，尽可能地简化代码，只保留必要的功能，避免不必要的复杂性。

YAGNI原则的优点在于：

1. 节省开发时间和成本，避免过度设计带来的浪费。
2. 简化代码，减少不必要的复杂性，提高代码的可读性和可维护性。
3. 更好地适应需求变化，只实现当前需要的功能，避免为未来可能的需求而设计。

YAGNI原则的实现可以通过以下几种方式：

1. 专注于当前需求，只实现必要的功能，避免过度设计。
2. 在设计和开发过程中不要预先考虑未来可能的需求，避免浪费时间和精力。
3. 避免添加不必要的代码和功能，保持代码的简洁性和清晰度。

YAGNI原则可以帮助程序员避免过度设计和浪费时间，更好地适应需求变化，提高代码的可读性和可维护性。同时，也是敏捷开发和极限编程等敏捷方法论中的一个重要原则。

## DRY（**Don't Repeat Yourself**）

DRY 强调避免在代码中重复相同的信息或逻辑。这个原则的基本思想是，每个概念或任务应该只有一个明确的表达方式，在代码中不应该出现重复的代码块或逻辑。

具体来说，DRY 原则的实现可以通过以下几种方式：

1. 提取公共代码：将重复的代码块提取出来，封装成函数或类，以便在程序中多次使用。
2. 使用模板或继承：将相同的逻辑抽象成一个模板或基类，子类只需要实现不同的细节即可。
3. 使用配置文件：将应用程序的参数或配置信息放在单独的配置文件中，以避免在代码中重复定义。

DRY 原则的实现可以帮助程序员避免代码重复，提高代码的可读性、可维护性和可扩展性。同时，DRY 原则也有助于降低代码中的 bug 数量，因为代码重复可能会导致修改困难、错误繁多。

需要注意的是，DRY 原则并不是一种绝对的原则，有时为了实现其他的设计目标，如性能优化或代码可读性，可能需要违反 DRY 原则。在实际编写代码时，需要综合考虑多个因素，找到最合适的平衡点。

# 代码设计模式

## 创建型模式

创建型模式用于处理对象的创建过程。

| 模式名称 | 描述 | 优点 | 缺点 | 适用场景 |
| --- | --- | --- | --- | --- |
| 简单工厂模式 | 通过一个工厂类来创建不同类型的对象，客户端只需要知道工厂类即可 | 简单易用，客户端与产品类解耦 | 工厂类职责过重，不易于扩展新的产品 | 对象创建比较简单的场景 |
| 工厂方法模式 | 将对象的创建延迟到子类中实现，由子类决定创建哪种对象 | 客户端与具体产品解耦，支持扩展新的产品 | 类的个数容易过多，增加了系统的抽象性和理解难度 | 对象的创建比较复杂的场景 |
| 抽象工厂模式 | 提供一个创建一系列相关或相互依赖对象的接口，而无需指定它们具体的类 | 保证创建的产品都是属于同一系列、同一风格的对象 | 增加新的产品族比较困难，会导致类的个数增加 | 创建一组相关对象的场景 |
| 单例模式 | 保证一个类只有一个实例，并提供全局访问点 | 保证全局唯一性，节省系统资源 | 职责过重，扩展困难，违反了单一职责原则 | 只需要一个实例的场景 |
| 建造者模式 | 将一个复杂对象的构建过程分解成多个简单对象的构建过程，将复杂对象的构建与表示分离 | 可以将一个复杂对象的构建与表示分离，使构建过程更加灵活 | 增加了系统的复杂度，需要额外的建造者类 | 创建一个复杂对象的场景 |
| 原型模式 | 通过克隆现有对象来创建新的对象，而不是通过实例化类 | 可以避免重复创建对象，提高性能 | 需要对克隆方法进行深度克隆处理，否则可能会出现引用对象问题 | 创建对象开销较大的场景 |

### 简单工厂模式（Simple Factory Pattern）

简单工厂模式是一种常见的创建型设计模式，用于创建对象，将对象的创建过程封装在一个工厂类中，从而实现更灵活的对象创建方式，简化客户端代码的编写。

简单工厂模式的核心思想是将对象的创建过程封装在一个工厂类中，该工厂类包含一个或多个静态方法，用于创建不同类型的对象实例。客户端通过调用工厂方法，获取不同类型的对象实例，从而实现更灵活和可扩展的对象创建方式。

简单工厂模式的优点在于：

1. 封装性好。简单工厂模式将对象的创建逻辑封装在工厂类中，客户端只需要知道所需对象的类型即可，无需了解对象的创建细节。
2. 可扩展性好。如果需要增加新的对象类型，只需要修改工厂类即可。
3. 代码复用性好。多个客户端可以共享同一个工厂类，从而减少了代码的重复。

简单工厂模式的缺点在于：

1. 不能很好地处理复杂对象的创建过程。如果对象的创建过程非常复杂，需要很多的参数或条件，那么简单工厂模式可能无法很好地处理这种情况。
2. 违背开放-封闭原则。如果需要增加新的对象类型，必须修改工厂类的代码，这可能会导致工厂类的代码变得越来越复杂。

```tsx
interface Animal {
  speak(): void;
}

class Dog implements Animal {
  public speak(): void {
    console.log("Woof!");
  }
}

class Cat implements Animal {
  public speak(): void {
    console.log("Meow!");
  }
}

class AnimalFactory {
  public static createAnimal(type: string): Animal {
    if (type === "dog") {
      return new Dog();
    } else if (type === "cat") {
      return new Cat();
    } else {
      throw new Error("Invalid animal type.");
    }
  }
}

// 使用示例
const dog = AnimalFactory.createAnimal("dog");
dog.speak(); // 输出 "Woof!"

const cat = AnimalFactory.createAnimal("cat");
cat.speak(); // 输出 "Meow!"
```

在这个示例中，我们定义了两个类 `Dog` 和 `Cat`，分别表示狗和猫。这两个类都实现了 `Animal` 接口，其中 `speak` 方法用于输出动物的叫声。

我们还定义了一个 `AnimalFactory` 工厂类，它根据所需的参数来创建相应的动物对象。在 `createAnimal` 方法中，我们使用了条件语句来判断所需的动物类型，并返回相应的实例。如果所需的动物类型无效，我们会抛出一个错误。

在主程序中，我们首先通过 `AnimalFactory` 工厂类创建了一个狗对象 `dog` 和一个猫对象 `cat`，然后分别调用它们的 `speak` 方法输出了它们的叫声。

### 工厂方法模式（Factory Method Pattern）

厂方法模式是一种常见的创建型设计模式，用于创建对象，将对象的创建过程委托给子类，从而实现更灵活的对象创建方式。

工厂方法模式的核心思想是将对象的创建过程抽象出来，定义一个抽象工厂类，该工厂类包含一个或多个创建对象的抽象方法，具体的对象创建过程由其子类实现。客户端通过调用工厂方法，获取不同类型的对象实例，从而实现更灵活和可扩展的对象创建方式。

工厂方法模式的优点在于：

1. 工厂方法模式可以将对象的创建过程和客户端代码解耦，使得客户端不需要关心对象的创建细节，从而提高代码的可维护性和可扩展性。
2. 工厂方法模式可以通过定义抽象工厂类和具体工厂类的层次结构，实现更加灵活的对象创建方式。
3. 工厂方法模式可以通过子类化来扩展对象的创建过程，增加新的产品时也不会影响到原有的代码。

工厂方法模式的缺点在于：

1. 工厂方法模式会增加系统的复杂度和抽象程度，不适合简单的对象创建场景。
2. 工厂方法模式需要定义抽象工厂类和具体工厂类，增加了代码的量。

```tsx
// 定义接口
interface Product {
  operation(): string;
}

// 定义具体产品类
class ConcreteProductA implements Product {
  public operation(): string {
    return 'ConcreteProductA';
  }
}

class ConcreteProductB implements Product {
  public operation(): string {
    return 'ConcreteProductB';
  }
}

// 定义抽象工厂类
abstract class Creator {
  public abstract createProduct(): Product;

  public doSomething(): void {
    console.log('Do something before create product');
  }

  public doSomethingElse(): void {
    console.log('Do something else after create product');
  }
}

// 定义具体工厂类
class ConcreteCreatorA extends Creator {
  public createProduct(): Product {
    return new ConcreteProductA();
  }
}

class ConcreteCreatorB extends Creator {
  public createProduct(): Product {
    return new ConcreteProductB();
  }
}

// 客户端代码
const creatorA = new ConcreteCreatorA();
const productA = creatorA.createProduct();
console.log(productA.operation()); // 输出 "ConcreteProductA"

const creatorB = new ConcreteCreatorB();
const productB = creatorB.createProduct();
console.log(productB.operation()); // 输出 "ConcreteProductB"
```

在上面的代码中，我们定义了一个 `Product` 接口，表示产品类的基本行为。然后定义了两个具体产品类 `ConcreteProductA` 和 `ConcreteProductB`，它们实现了 `Product` 接口，并提供了自己的实现。接着，我们定义了一个抽象工厂类 `Creator`，它包含一个抽象方法 `createProduct`，由其子类实现具体的产品创建过程。最后，我们定义了两个具体工厂类 `ConcreteCreatorA` 和 `ConcreteCreatorB`，它们分别实现了 `Creator` 接口，并提供了自己的产品创建逻辑。在客户端代码中，我们可以通过创建具体的工厂类实例，获取不同类型的产品实例，并调用它们的 `operation` 方法。

### 抽象工厂模式（Abstract Factory Pattern）

抽象工厂模式是一种常见的创建型设计模式，用于创建一系列相关或相互依赖的对象，将对象的创建过程抽象出来，以便更灵活地创建对象，同时也可以提高代码的可维护性和可扩展性。

抽象工厂模式的核心思想是将对象的创建过程抽象出来，定义一个抽象工厂类，该工厂类包含一系列创建对象的抽象方法，具体的对象创建过程由其子类实现。客户端通过调用工厂方法，获取一系列相关的对象实例，从而实现更灵活和可扩展的对象创建方式。

抽象工厂模式的优点在于：

1. 抽象工厂模式可以将对象的创建过程和客户端代码解耦，使得客户端不需要关心对象的创建细节，从而提高代码的可维护性和可扩展性。
2. 抽象工厂模式可以提供一系列相关或相互依赖的对象，使得客户端可以更加方便地使用这些对象，并且可以保证这些对象之间的一致性。
3. 抽象工厂模式可以通过定义抽象工厂类和具体工厂类的层次结构，实现更加灵活的对象创建方式。

抽象工厂模式的缺点在于：

1. 抽象工厂模式的扩展性不太好，如果需要添加新的产品族，需要修改抽象工厂类和所有具体工厂类的代码。
2. 抽象工厂模式会增加系统的复杂度和抽象程度，不适合简单的对象创建场景。

```tsx
// 定义接口
interface Button {
  paint(): void;
}

interface Input {
  paint(): void;
}

// 定义具体产品类
class WindowsButton implements Button {
  public paint(): void {
    console.log('Paint Windows button');
  }
}

class WindowsInput implements Input {
  public paint(): void {
    console.log('Paint Windows input');
  }
}

class MacButton implements Button {
  public paint(): void {
    console.log('Paint Mac button');
  }
}

class MacInput implements Input {
  public paint(): void {
    console.log('Paint Mac input');
  }
}

// 定义抽象工厂类
abstract class AbstractFactory {
  public abstract createButton(): Button;
  public abstract createInput(): Input;
}

// 定义具体工厂类
class WindowsFactory extends AbstractFactory {
  public createButton(): Button {
    return new WindowsButton();
  }

  public createInput(): Input {
    return new WindowsInput();
  }
}

class MacFactory extends AbstractFactory {
  public createButton(): Button {
    return new MacButton();
  }

  public createInput(): Input {
    return new MacInput();
  }
}

// 客户端代码
const windowsFactory = new WindowsFactory();
const windowsButton = windowsFactory.createButton();
windowsButton.paint(); // 输出 "Paint Windows button"
const windowsInput = windowsFactory.createInput();
windowsInput.paint(); // 输出 "Paint Windows input"

const macFactory = new MacFactory();
const macButton = macFactory.createButton();
macButton.paint(); // 输出 "Paint Mac button"
const macInput = macFactory.createInput();
macInput.paint(); // 输出 "Paint Mac input"
```

在上面的代码中，我们定义了两个产品族 `Button` 和 `Input`，分别包含 Windows 和 Mac 系统的具体产品类。然后定义了一个抽象工厂类 `AbstractFactory`，该工厂类包含两个抽象方法 `createButton` 和 `createInput`，由其子类实现具体的产品创建过程。最后，我们定义了两个具体工厂类 `WindowsFactory` 和 `MacFactory`，它们分别实现了 `AbstractFactory` 接口，并提供了自己的产品创建逻辑。在客户端代码中，我们可以通过创建具体的工厂类实例，获取一系列相关的对象实例，并调用它们的 `paint` 方法。

### 建造者模式（Builder Pattern）

建造者模式是一种常见的创建型设计模式，用于创建复杂对象，将对象的创建过程分解成多个步骤，使得对象创建过程更加灵活和可扩展。

建造者模式的核心思想是将对象的创建过程分解成多个步骤，定义一个抽象建造者类，该类包含多个抽象方法，用于定义不同的建造步骤。然后定义一个具体建造者类，实现抽象建造者类的方法，完成具体的建造步骤。最后定义一个指导者类，通过调用建造者类的方法，按照特定的顺序执行建造步骤，最终返回一个完整的复杂对象实例。

建造者模式的优点在于：

1. 建造者模式可以将对象的创建过程分解成多个步骤，使得创建过程更加灵活和可扩展，同时也可以降低创建过程的复杂度。
2. 建造者模式可以通过指导者类来控制建造过程的顺序，从而保证建造过程的正确性。
3. 建造者模式可以通过定义不同的具体建造者类，实现不同类型的对象创建。

建造者模式的缺点在于：

1. 建造者模式会增加系统的复杂度和抽象程度，不适合简单的对象创建场景。
2. 建造者模式需要定义抽象建造者类和具体建造者类，增加了代码的量。

```tsx
// 定义产品类
class Product {
  public parts: string[] = [];

  public listParts(): void {
    console.log(`Product parts: ${this.parts.join(', ')}\n`);
  }
}

// 定义抽象建造者类
abstract class Builder {
  public abstract reset(): void;
  public abstract buildPartA(): void;
  public abstract buildPartB(): void;
  public abstract buildPartC(): void;
  public abstract getProduct(): Product;
}

// 定义具体建造者类
class ConcreteBuilder extends Builder {
  private product: Product;

  constructor() {
    super();
    this.reset();
  }

  public reset(): void {
    this.product = new Product();
  }

  public buildPartA(): void {
    this.product.parts.push('Part A');
  }

  public buildPartB(): void {
    this.product.parts.push('Part B');
  }

  public buildPartC(): void {
    this.product.parts.push('Part C');
  }

  public getProduct(): Product {
    const result = this.product;
    this.reset();
    return result;
  }
}

// 定义指导者类
class Director {
  private builder: Builder;

  public setBuilder(builder: Builder): void {
    this.builder = builder;
  }

  public buildMinimalProduct(): void {
    this.builder.buildPartA();
  }

  public buildFullFeaturedProduct(): void {
    this.builder.buildPartA();
    this.builder.buildPartB();
    this.builder.buildPartC();
  }
}

// 客户端代码
const director = new Director();
const builder = new ConcreteBuilder();
director.setBuilder(builder);

director.buildMinimalProduct();
const productA = builder.getProduct();
productA.listParts(); // 输出 "Product parts: Part A"

director.buildFullFeaturedProduct();
const productB = builder.getProduct();
productB.listParts(); // 输出 "Product parts: Part A, Part B, Part C"
```

在上面的代码中，我们定义了一个产品类 `Product`，它包含一个 `parts` 属性，用于存储产品的各个部分。然后定义了一个抽象建造者类 `Builder`，它包含多个抽象方法，用于定义不同的建造步骤。接着，我们定义了一个具体建造者类 `ConcreteBuilder`，它实现了抽象建造者类的方法，完成具体的建造步骤，并通过 `getProduct` 方法返回一个完整的产品实例。最后，我们定义了一个指导者类 `Director`，通过调用建造者类的方法，按照特定的顺序执行建造步骤，最终返回一个完整的复杂对象实例。

### 原型模式（Prototype Pattern）

原型模式是一种常见的创建型设计模式，用于创建对象，通过复制现有对象来创建新对象，从而避免了对象的重复创建和初始化过程。

原型模式的核心思想是通过复制现有对象来创建新对象，原型模式提供了一种更加灵活和可扩展的对象创建方式。在原型模式中，我们首先创建一个原型对象，然后通过克隆原型对象来创建新对象，从而避免了对象的重复创建和初始化过程。

原型模式的优点在于：

1. 原型模式可以避免对象的重复创建和初始化过程，从而提高了对象创建的效率。
2. 原型模式可以通过克隆原型对象来创建新对象，从而提供了一种更加灵活和可扩展的对象创建方式。
3. 原型模式可以通过修改原型对象的属性和方法，来实现多个不同类型的对象创建。

原型模式的缺点在于：

1. 原型模式需要对原型对象进行复制，可能会增加系统的内存消耗。
2. 原型模式需要对原型对象进行深度克隆，以避免对象的引用关系对克隆结果的影响。

原型模式通过复制现有对象来创建新对象，避免了对象的重复创建和初始化过程，提高了对象创建的效率，同时也提供了一种更加灵活和可扩展的对象创建方式。

```tsx
// 定义原型类
abstract class Prototype {
  public abstract clone(): Prototype;
}

// 定义具体原型类
class ConcretePrototype1 extends Prototype {
  public clone(): Prototype {
    return new ConcretePrototype1();
  }
}

class ConcretePrototype2 extends Prototype {
  public clone(): Prototype {
    return new ConcretePrototype2();
  }
}

// 客户端代码
const prototype1 = new ConcretePrototype1();
const clone1 = prototype1.clone();

const prototype2 = new ConcretePrototype2();
const clone2 = prototype2.clone();
```

在上面的代码中，我们定义了一个抽象原型类 `Prototype`，它包含一个抽象方法 `clone`，用于复制原型对象。然后定义了两个具体原型类 `ConcretePrototype1` 和 `ConcretePrototype2`，它们实现了 `Prototype` 接口，并提供了自己的复制方法。在客户端代码中，我们首先创建具体原型类的实例，然后通过调用 `clone` 方法，复制原型对象，从而创建新对象。

### 单例模式（Singleton Pattern）

单例模式是一种常见的创建型设计模式，用于保证一个类仅有一个实例，并提供全局访问点。

单例模式的核心思想是通过限制一个类只能创建一个实例，来保证该类的唯一性，并提供全局访问点。在单例模式中，我们通常将类的构造函数定义为私有的，这样就不能从外部直接创建该类的实例，而是通过一个静态方法来获取该类的唯一实例。如果该类已经创建了实例，则直接返回该实例，否则就创建一个新实例并返回。

单例模式的优点在于：

1. 单例模式可以保证一个类只有一个实例，避免了对象的重复创建和内存浪费。
2. 单例模式可以提供全局访问点，方便其他对象对该类的访问。
3. 单例模式可以对资源进行统一管理，例如数据库连接池、线程池等。

单例模式的缺点在于：

1. 单例模式会增加系统的复杂度和耦合度，不利于代码的维护和扩展。
2. 单例模式的实现需要考虑线程安全和并发访问，可能会增加代码的复杂度。

```tsx
// 定义单例类
class Singleton {
  private static instance: Singleton;

  private constructor() {}

  public static getInstance(): Singleton {
    if (!Singleton.instance) {
      Singleton.instance = new Singleton();
    }
    return Singleton.instance;
  }

  public doSomething(): void {
    console.log('Singleton do something');
  }
}

// 客户端代码
const singleton1 = Singleton.getInstance();
singleton1.doSomething(); // 输出 "Singleton do something"

const singleton2 = Singleton.getInstance();
console.log(singleton1 === singleton2); // 输出 true
```

在上面的代码中，我们定义了一个单例类 `Singleton`，它包含一个私有的静态属性 `instance`，用于存储该类的唯一实例。然后定义了一个私有的构造函数，用于限制该类的实例数量。在 `getInstance` 方法中，如果该类的实例不存在，则创建一个新实例并返回；否则直接返回该实例。在客户端代码中，我们通过 `getInstance` 方法获取单例类的唯一实例，并调用其方法。

## 结构型模式

结构型模式用于处理对象和类之间的关系。

| 模式名称 | 描述 | 优点 | 缺点 | 适用场景 |
| --- | --- | --- | --- | --- |
| 适配器模式 | 将一个类的接口转换成客户端所期望的另一种接口形式，使得原本由于接口不兼容而不能一起工作的类可以一起工作 | 提高代码复用性和灵活性，可以让客户端使用不同的接口 | 增加了系统的复杂度，需要额外的适配器类 | 旧接口无法满足新需求的场景 |
| 桥接模式 | 将抽象部分与它的实现部分分离，使它们可以独立变化 | 可以减少类的数量，提高代码的可扩展性和可维护性 | 增加了系统的抽象性和理解难度 | 抽象和实现部分的变化独立的场景 |
| 组合模式 | 将对象组合成树形结构来表示“整体/部分”层次关系，使得客户端可以统一处理单个对象和组合对象 | 简化客户端代码，可以统一对待组合对象和单个对象 | 增加了系统的抽象性和理解难度，不容易限制组合中的组件类型 | 需要表示“整体/部分”层次关系的场景 |
| 装饰器模式 | 动态地给一个对象添加一些额外的职责，同时又不改变其结构 | 可以灵活地添加和删除对象的职责，不影响其他对象 | 可能会导致类的数量增加，装饰过多会影响代码可读性 | 动态地添加和删除对象的职责的场景 |
| 外观模式 | 为子系统中的一组接口提供一个统一的接口，使得对该子系统的访问更容易 | 简化了客户端的调用过程，降低了客户端与子系统之间的耦合度 | 可能会导致子系统更难以修改和扩展 | 需要提供简单的接口给客户端的场景 |
| 享元模式 | 将对象的共同部分提取出来，作为多个对象的共享部分，以减少对象的数量和节约内存 | 可以减少对象的数量和节约内存 | 需要维护享元对象的内部状态和外部状态的区分，增加了系统的复杂度 | 需要创建大量相似对象的场景 |
| 代理模式 | 为其他对象提供一种代理以控制对这个对象的访问 | 可以在不改变原有代码的情况下增加额外的功能 | 会增加系统的复杂度，可能会影响到访问对象的性能 | 需要控制对对象的访问的场景 |

### 适配器模式（Adapter Pattern）

适配器模式是一种常见的结构型设计模式，用于将接口不兼容的对象进行转换，从而让它们能够正常协作。

在适配器模式中，我们定义一个适配器类，该类包含一个目标接口（即要转换成的接口）和一个被适配者对象（即要进行转换的对象）。适配器类实现目标接口，并将目标接口的方法转换成被适配者对象的方法，从而让它们能够正常协作。

适配器模式的优点在于：

1. 适配器模式可以让不兼容的对象能够正常协作，提高了系统的灵活性和可扩展性。
2. 适配器模式可以复用现有的对象，避免了重复开发和维护的工作量。
3. 适配器模式可以将不同的系统进行无缝集成，提高了系统的整体性能和效率。

适配器模式的缺点在于：

1. 适配器模式增加了系统的复杂度和耦合度，不利于代码的维护和扩展。
2. 适配器模式需要考虑被适配者对象的接口和实现细节，可能会增加代码的复杂度。

```tsx
interface MediaPlayer {
  play(audioType: string, fileName: string): void;
}

class Mp3Player {
  public playMp3(fileName: string): void {
    console.log('Playing mp3 file. Name: ' + fileName);
  }
}

class VlcPlayer {
  public playVlc(fileName: string): void {
    console.log('Playing vlc file. Name: ' + fileName);
  }
}

class MediaAdapter implements MediaPlayer {
  private mp3Player: Mp3Player;
  private vlcPlayer: VlcPlayer;

  constructor() {
    this.mp3Player = new Mp3Player();
    this.vlcPlayer = new VlcPlayer();
  }

  public play(audioType: string, fileName: string): void {
    if (audioType === 'mp3') {
      this.mp3Player.playMp3(fileName);
    } else if (audioType === 'vlc') {
      this.vlcPlayer.playVlc(fileName);
    }
  }
}

const mediaPlayer: MediaPlayer = new MediaAdapter();

mediaPlayer.play('mp3', 'beyond the horizon.mp3');
mediaPlayer.play('vlc', 'alone.vlc');
```

在上面的代码中，我们首先定义了一个 `MediaPlayer` 接口，它定义了一个 `play` 方法。然后定义了两个不兼容的类 `Mp3Player` 和 `VlcPlayer`，它们分别实现了播放 MP3 和 VLC 格式的音频文件。为了让它们能够正常协作，我们实现了一个 `MediaAdapter` 适配器类，该类实现了 `MediaPlayer` 接口，并将 `play` 方法转换成 `playMp3` 和 `playVlc` 方法。在客户端代码中，我们使用适配器类来播放 MP3 和 VLC 格式的音频文件。

### 桥接模式（Bridge Pattern）

桥接模式是一种常见的结构型设计模式，用于将抽象部分和实现部分分离，从而让它们可以独立地变化。

在桥接模式中，我们定义一个抽象类和一个实现类，抽象类包含一个指向实现类的引用，从而将抽象部分和实现部分分离开来。在客户端代码中，我们可以通过注入不同的实现类，来创建不同类型的对象，从而实现不同的功能。

桥接模式的优点在于：

1. 桥接模式可以将抽象部分和实现部分分离开来，从而提高了系统的灵活性和可扩展性。
2. 桥接模式可以让抽象部分和实现部分独立地变化，不会互相影响，从而降低了系统的复杂度。
3. 桥接模式可以提高系统的可维护性和可重用性，使系统更加稳定和可靠。

桥接模式的缺点在于：

1. 桥接模式增加了系统的复杂度和理解难度，不利于代码的维护和理解。
2. 桥接模式需要预先定义抽象类和实现类之间的关系，可能会增加开发和设计的工作量。

```tsx
interface DrawingAPI {
  drawCircle(x: number, y: number, radius: number): void;
}

abstract class Shape {
  protected drawingAPI: DrawingAPI;

  constructor(drawingAPI: DrawingAPI) {
    this.drawingAPI = drawingAPI;
  }

  public abstract draw(): void;
}

class CircleShape extends Shape {
  private x: number;
  private y: number;
  private radius: number;

  constructor(x: number, y: number, radius: number, drawingAPI: DrawingAPI) {
    super(drawingAPI);
    this.x = x;
    this.y = y;
    this.radius = radius;
  }

  public draw(): void {
    this.drawingAPI.drawCircle(this.x, this.y, this.radius);
  }
}

class SquareShape extends Shape {
  private x: number;
  private y: number;
  private size: number;

  constructor(x: number, y: number, size: number, drawingAPI: DrawingAPI) {
    super(drawingAPI);
    this.x = x;
    this.y = y;
    this.size = size;
  }

  public draw(): void {
    // 绘制正方形
  }
}

class V1DrawingAPI implements DrawingAPI {
  public drawCircle(x: number, y: number, radius: number): void {
    console.log(`Drawing API V1: Circle [${x}, ${y}, ${radius}]`);
  }
}

class V2DrawingAPI implements DrawingAPI {
  public drawCircle(x: number, y: number, radius: number): void {
    console.log(`Drawing API V2: Circle [${x}, ${y}, ${radius}]`);
  }
}

const circleShape1 = new CircleShape(1, 2, 3, new V1DrawingAPI());
circleShape1.draw(); // Drawing API V1: Circle [1, 2, 3]

const circleShape2 = new CircleShape(4, 5, 6, new V2DrawingAPI());
circleShape2.draw(); // Drawing API V2: Circle [4, 5, 6]
```

在上面的代码中，我们首先定义了一个 `DrawingAPI` 接口和一个 `Shape` 抽象类，抽象类包含一个指向 `DrawingAPI` 的引用，用于绘制图形。然后定义了两个具体类 `CircleShape` 和 `SquareShape`，它们分别继承自 `Shape` 类，实现了不同类型的图形绘制。在客户端代码中，我们注入不同类型的 `DrawingAPI` 实现类来创建不同类型的图形对象，并调用 `draw` 方法来绘制图形。

### 组合模式（Composite Pattern）

组合模式是一种常见的结构型设计模式，用于将对象组合成树形结构，以表示“部分-整体”的层次结构。

组合模式中，我们定义一个抽象类和一个具体类，抽象类包含一个指向子类的引用，从而将部分和整体都看作是相同的。在客户端代码中，我们可以通过递归遍历整个树形结构，来访问每个部分对象的方法。

组合模式的优点在于：

1. 组合模式可以让我们以树形结构来表示对象之间的层次关系，从而方便我们对对象进行操作和管理。
2. 组合模式可以让我们将部分和整体都看作是相同的，从而简化了代码的结构和设计。
3. 组合模式可以提高代码的复用性和可维护性，使代码更加稳定和可靠。

组合模式的缺点在于：

1. 组合模式可能会增加系统的复杂度和理解难度，不利于代码的维护和理解。
2. 组合模式需要预先定义整个树形结构，可能会增加开发和设计的工作量。

```tsx
abstract class Component {
  protected parent: Component | null;

  constructor(parent: Component | null = null) {
    this.parent = parent;
  }

  public setParent(parent: Component | null) {
    this.parent = parent;
  }

  public getParent(): Component | null {
    return this.parent;
  }

  public abstract operation(): string;
}

class Composite extends Component {
  private children: Component[] = [];

  public add(component: Component): void {
    this.children.push(component);
    component.setParent(this);
  }

  public remove(component: Component): void {
    const componentIndex = this.children.indexOf(component);
    if (componentIndex !== -1) {
      this.children.splice(componentIndex, 1);
      component.setParent(null);
    }
  }

  public operation(): string {
    const results = [];
    for (const child of this.children) {
      results.push(child.operation());
    }
    return `Branch(${results.join('+')})`;
  }
}

class Leaf extends Component {
  public operation(): string {
    return 'Leaf';
  }
}
const branch1 = new Composite();
const branch2 = new Composite();
const leaf1 = new Leaf();
const leaf2 = new Leaf();
const leaf3 = new Leaf();

branch1.add(leaf1);
branch1.add(branch2);

branch2.add(leaf2);
branch2.add(leaf3);

console.log(branch1.operation()); // Branch(Leaf+Branch(Leaf+Leaf))
```

在上面的代码中，我们首先定义了一个 `Component` 抽象类和一个 `Composite` 类，抽象类包含一个指向子类的引用，用于访问子节点。然后定义了一个 `Leaf` 类，它继承自 `Component` 类，表示树形结构中的叶子节点。在客户端代码中，我们创建了一个 `Composite` 对象，并向其中添加多个子节点（包括叶子节点和分支节点），然后递归遍历整个树形结构，访问每个部分对象的方法。

### 装饰器模式（Decorator Pattern）

装饰器模式（Decorator Pattern）是一种常见的结构型设计模式，用于在运行时动态地为对象添加额外的行为，而不需要修改现有的类或对象。

在装饰器模式中，我们定义一个抽象类和一个具体类，抽象类包含一个指向具体类的引用，从而将装饰器和被装饰对象分离开来。在客户端代码中，我们可以通过注入不同的具体装饰器，来为对象添加不同的行为。

```tsx
abstract class Component {
  public abstract operation(): string;
}

class ConcreteComponent extends Component {
  public operation(): string {
    return 'ConcreteComponent';
  }
}

abstract class Decorator extends Component {
  protected component: Component;

  constructor(component: Component) {
    super();
    this.component = component;
  }

  public operation(): string {
    return this.component.operation();
  }
}

class ConcreteDecoratorA extends Decorator {
  public operation(): string {
    return `ConcreteDecoratorA(${super.operation()})`;
  }
}

class ConcreteDecoratorB extends Decorator {
  public operation(): string {
    return `ConcreteDecoratorB(${super.operation()})`;
  }
}

const component = new ConcreteComponent();
console.log(component.operation()); // ConcreteComponent

const decoratedComponentA = new ConcreteDecoratorA(component);
const decoratedComponentB = new ConcreteDecoratorB(decoratedComponentA);
console.log(decoratedComponentB.operation()); // ConcreteDecoratorB(ConcreteDecoratorA(ConcreteComponent))
```

在上面的代码中，我们首先定义了一个 `Component` 抽象类和一个 `ConcreteComponent` 具体类，`Component` 类包含一个指向具体类的引用，用于访问被装饰对象。然后定义了一个 `Decorator` 抽象类和多个具体装饰器类，`Decorator` 类包含一个指向被装饰对象的引用，用于在运行时动态地为对象添加额外的行为。在客户端代码中，我们创建了一个 `ConcreteComponent` 对象，并注入多个具体装饰器，动态地为对象添加额外的行为。

### 外观模式（Facade Pattern）

外观模式（Facade Pattern）是一种常见的结构型设计模式，用于为复杂的系统提供一个简单的接口，以隐藏系统的复杂性并简化客户端代码。

在外观模式中，我们定义一个外观类，该类充当客户端和系统之间的中介，将客户端请求转发给系统内部的各个部分。外观类隐藏了系统内部的实现细节，从而简化了客户端代码。

外观模式的优点在于：

1. 外观模式可以隐藏系统内部的实现细节，从而简化了客户端代码。
2. 外观模式可以降低系统的复杂度，使系统更加易于维护和扩展。
3. 外观模式可以提高代码的复用性和可维护性，使代码更加稳定和可靠。

外观模式的缺点在于：

1. 外观模式可能会增加系统的理解难度，不利于代码的维护和理解。
2. 外观模式可能会限制系统的灵活性，使系统更加僵化和不易扩展。

```tsx
class Subsystem1 {
  public operation1(): string {
    return 'Subsystem1: Ready!';
  }
}

class Subsystem2 {
  public operation2(): string {
    return 'Subsystem2: Go!';
  }
}

class Subsystem3 {
  public operation3(): string {
    return 'Subsystem3: Fire!';
  }
}

class Facade {
  private subsystem1: Subsystem1;
  private subsystem2: Subsystem2;
  private subsystem3: Subsystem3;

  constructor() {
    this.subsystem1 = new Subsystem1();
    this.subsystem2 = new Subsystem2();
    this.subsystem3 = new Subsystem3();
  }

  public operation(): string {
    let result = 'Facade initializes subsystems\n';
    result += this.subsystem1.operation1() + '\n';
    result += this.subsystem2.operation2() + '\n';
    result += this.subsystem3.operation3() + '\n';
    return result;
  }
}
const facade = new Facade();
console.log(facade.operation());
```

在上面的代码中，我们首先定义了多个子系统 `Subsystem1`、`Subsystem2` 和 `Subsystem3`，每个子系统都有自己的接口和实现。然后定义了一个外观类 `Facade`，该类充当客户端和系统之间的中介，将客户端请求转发给系统内部的各个部分。在客户端代码中，我们创建了一个 `Facade` 对象，并调用其 `operation` 方法，该方法将客户端请求转发给系统内部的各个部分。

### 享元模式（Flyweight Pattern）

享元模式是一种常见的结构型设计模式，用于共享细粒度的对象，以节省内存和提高性能。

在享元模式中，我们将需要共享的对象抽象出来，定义一个工厂类来负责创建和管理对象的共享和缓存。在客户端代码中，我们可以通过工厂类获取需要的对象，从而减少内存的使用。

享元模式的优点在于：

1. 享元模式可以减少内存的使用，提高系统的性能和效率。
2. 享元模式可以提高代码的复用性和可维护性，使代码更加稳定和可靠。
3. 享元模式可以降低系统的复杂度，使系统更加易于维护和扩展。

享元模式的缺点在于：

1. 享元模式可能会增加系统的理解难度，不利于代码的维护和理解。
2. 享元模式可能会影响系统的灵活性，特别是在需要修改共享对象时。

```tsx
abstract class Shape {
  public abstract draw(x: number, y: number): void;
}

class Circle extends Shape {
  private color: string;

  constructor(color: string) {
    super();
    this.color = color;
  }

  public draw(x: number, y: number): void {
    console.log(`Drawing circle with color ${this.color} at (${x}, ${y})`);
  }
}

class Square extends Shape {
  private color: string;

  constructor(color: string) {
    super();
    this.color = color;
  }

  public draw(x: number, y: number): void {
    console.log(`Drawing square with color ${this.color} at (${x}, ${y})`);
  }
}

class ShapeFactory {
  private static shapes: { [key: string]: Shape } = {};

  public static getShape(color: string, type: string): Shape {
    const key = `${color}_${type}`;
    if (!ShapeFactory.shapes[key]) {
      if (type === 'circle') {
        ShapeFactory.shapes[key] = new Circle(color);
      } else if (type === 'square') {
        ShapeFactory.shapes[key] = new Square(color);
      }
    }
    return ShapeFactory.shapes[key];
  }
}

const shapes: Shape[] = [];

shapes.push(ShapeFactory.getShape('red', 'circle'));
shapes.push(ShapeFactory.getShape('blue', 'circle'));
shapes.push(ShapeFactory.getShape('green', 'square'));
shapes.push(ShapeFactory.getShape('red', 'square'));

for (const shape of shapes) {
  shape.draw(10, 10);
}
```

在上面的代码中，我们首先定义了一个 `Shape` 抽象类和多个具体图形类，每个具体图形类都有自己的颜色和绘制方法。然后定义了一个工厂类 `ShapeFactory`，该类负责创建和管理共享对象。在客户端代码中，我们通过工厂类 `ShapeFactory` 获取需要的对象，从而减少内存的使用。

### 代理模式（Proxy Pattern）

代理模式是一种常见的结构型设计模式，通过一个代理对象来控制对另一个对象的访问，以实现访问控制、远程访问、延迟加载等功能。

在代理模式中，我们定义一个代理类，该类充当客户端和另一个对象之间的中介，可以在客户端和另一个对象之间添加一些额外的逻辑，从而实现访问控制、远程访问、延迟加载等功能。

代理模式的优点在于：

1. 代理模式可以控制对另一个对象的访问，实现访问控制和权限管理。
2. 代理模式可以实现远程访问，使得客户端可以访问远程的对象。
3. 代理模式可以实现延迟加载，避免在不必要的情况下加载和初始化对象。

代理模式的缺点在于：

1. 代理模式可能会增加系统的理解难度，不利于代码的维护和理解。
2. 代理模式可能会降低系统的性能和效率，特别是在需要频繁访问另一个对象时。

```tsx
interface Image {
  display(): void;
}

class RealImage implements Image {
  private filename: string;

  constructor(filename: string) {
    this.filename = filename;
    this.loadFromDisk();
  }

  public display(): void {
    console.log(`Displaying ${this.filename}`);
  }

  private loadFromDisk(): void {
    console.log(`Loading ${this.filename} from disk`);
  }
}

class ImageProxy implements Image {
  private realImage: RealImage;
  private filename: string;

  constructor(filename: string) {
    this.filename = filename;
  }

  public display(): void {
    if (!this.realImage) {
      this.realImage = new RealImage(this.filename);
    }
    this.realImage.display();
  }
}

const image: Image = new ImageProxy('test.jpg');
image.display();
```

在上面的代码中，我们首先定义了一个 `Image` 接口和多个具体图片类，每个具体图片类都有自己的文件路径和加载方法。然后定义了一个代理类 `ImageProxy`，该类充当客户端和具体图片类之间的中介，控制对具体图片类的访问。在客户端代码中，我们创建了一个 `Image` 对象，并调用其 `display` 方法，该方法将客户端请求转发给具体图片类。

## 行为型模式

行为型模式用于处理对象之间的通信和协作。

| 模式名称 | 定义 | 适用场景 | 优点 | 缺点 |
| --- | --- | --- | --- | --- |
| 观察者模式 | 定义对象间的一种一对多的关系，使得多个观察者对象同时监听某一个主题对象，当主题对象状态发生变化时，会通知所有观察者对象，使它们能够自动更新自己。 | 当一个对象的改变需要同时改变其他对象，而且不知道具体有多少对象有待改变时。 | 1. 降低了对象之间的耦合度；2. 支持广播通信；3. 符合开闭原则。 | 1. 如果一个观察者对象需要监听多个主题对象，会导致代码复杂性增加；2. 如果观察者对象和主题对象之间有循环依赖关系，会导致系统崩溃。 |
| 迭代器模式 | 提供一种方法来顺序访问一个聚合对象中的各个元素，而又不暴露该对象的内部表示。 | 当需要访问一个聚合对象，而且不管这些对象是什么都需要遍历时。 | 1. 简化了遍历方式；2. 对于不同的聚合结构，可以提供一个统一的遍历接口。 | 1. 增加了系统的复杂度；2. 迭代器模式将遍历逻辑放到了迭代器中，导致了增加了系统的类的数量。 |
| 模板方法模式 | 定义一个操作中的算法骨架，而将一些步骤延迟到子类中，使得子类可以不改变一个算法的结构即可重定义该算法的某些特定步骤。 | 当需要实现一些通用的算法，同时又有一些步骤是可变的时。 | 1. 封装了不变部分，扩展可变部分；2. 提取公共部分代码，便于维护；3. 行为由父类控制，子类实现。 | 1. 模板方法在定义时需要考虑到所有子类的公共行为，增加了系统的抽象性；2. 模板方法可能会导致代码阅读和理解的难度加大。 |
| 策略模式 | 定义一组算法，将每个算法都封装起来，并且使它们之间可以互换。 | 当需要在不同的场景中使用不同的算法时。 | 1. 封装了变化部分，便于扩展和维护；2. 算法可以自由切换；3. 避免使用多重条件判断；4. 提供了对开闭原则的支持。 | 1. 客户端必须知道所有的策略类，并自行决定使用哪一个策略类；2. 策略模式会增加系统中类的数量。 |
| 命令模式 | 将一个请求封装为一个对象，从而使你可用不同的请求对客户进行参数化，对请求排队或记录请求日志，以及支持可撤销的操作。 | 当需要将请求发送者和请求接收者解耦时。 | 1. 降低了系统的耦合度；2. 新的命令可以很容易地添加到系统中；3. 可以实现撤销和重做功能。 | 1. 增加了系统的复杂度；2. 可能会导致系统中类的数量增加；3. 可能会增加系统维护的难度。 |
| 职责链模式 | 为了避免请求发送者和请求接收者之间的耦合关系，使得多个对象都有机会处理请求，将这些对象连成一条链，并沿着这条链传递该请求，直到有一个对象处理它为止。 | 当需要动态地指定处理一个请求的对象集合时。 | 1. 降低了系统的耦合度；2. 请求的发送者不需要知道请求的处理细节；3. 可以动态地增加或修改处理请求的对象。 | 1. 处理请求的对象不能保证被唯一地确定；2. 对象的链表太长或者处理时间过长，影响系统的性能。 |
| 访问者模式 | 将数据结构与数据操作分离，使得数据结构可以独立于数据操作进行变化。 | 当需要对一个对象结构中的元素进行复杂的操作，而且不希望在这些元素类中添加这些操作时。 | 1. 增加了系统的灵活性和可扩展性；2. 将相关的操作集中在访问者中，使得代码更加清晰、易于维护和扩展。 | 1. 增加了系统的复杂度；2. 增加了代码的阅读和理解难度；3. 在访问者对象中添加新的操作可能会导致访问者对象变得臃肿和复杂。 |
| 中介者模式 | 用一个中介对象来封装一系列的对象交互，中介者使各对象不需要显式地互相作用，从而使其耦合松散，而且可以独立地改变它们之间的交互。 | 当需要通过一个中间对象来协调其他对象之间的交互时。 | 1. 减少了对象之间的耦合度；2. 将对象间的一对多关系转化为一对一关系；3. 可以简化对象的交互。 | 1. 增加了系统的复杂度；2. 中介者对象本身可能会变得复杂和难以维护。 |
| 备忘录模式 | 在不破坏对象的封装性的前提下，捕获一个对象的内部状态，并在该对象之外保存这个状态。备忘录模式提供了一种可以恢复对象状态的机制，可以使得对象恢复到之前的状态。 | 当需要保存一个对象在某一个时刻的状态，并允许恢复到该状态时。例如，文本编辑器中的撤销和恢复操作。 | 1. 可以在不破坏对象封装性的前提下实现对象状态的保存和恢复；2. 可以简化代码的复杂性。 | 1. 可能会消耗大量的内存，需要谨慎使用。 |
| 解释器模式 | 给定一个语言，在该语言中定义一组文法规则，然后使用解释器来解释这些规则。解释器模式提供了一种定义语言的方式，并且可以解释和执行语言中定义的规则。 | 当需要定义一种语言，或者需要执行一些规则时。例如，编译器和计算器。 | 1. 可以扩展语言或规则的定义；2. 可以实现文法规则的解释和执行。 | 1. 可能会增加系统的复杂度；2. 需要谨慎设计文法规则。 |
| 状态模式 | 当一个对象的状态发生改变时，它所表现的行为也会发生改变。状态模式将对象的状态封装成一个状态对象，使得对象的状态可以在运行时动态地改变。 | 当需要根据对象状态改变行为时。例如，订单的状态和相应的处理方式。 | 1. 将状态和状态对应的行为封装起来，使得代码更加清晰、易于维护和扩展；2. 将状态转换逻辑分布到状态类中，使得状态转换更加简单。 | 1. 可能会增加系统的复杂度；2. 需要谨慎设计状态转换逻辑。 |

### 责任链模式（Chain of Responsibility Pattern）

责任链模式是一种常见的行为型设计模式，用于处理请求并将请求传递给多个对象处理。将请求和处理分离，构建一个请求处理链。

在责任链模式中，我们定义一个抽象处理器类，该类包含一个指向下一个处理器的引用，每个具体处理器类都负责处理自己能够处理的请求，如果无法处理，则将请求传递给下一个处理器，直至请求被处理完毕或没有处理器能够处理该请求。

责任链模式的优点在于：

1. 责任链模式可以灵活地处理请求，每个处理器可以处理自己能够处理的请求，从而提高代码的复用性和可维护性。
2. 责任链模式可以降低系统的耦合度，使系统更加灵活和可扩展。
3. 责任链模式可以实现请求的过滤和拦截，从而实现安全控制和权限管理等功能。

责任链模式的缺点在于：

1. 责任链模式可能会导致请求被多次处理，从而影响系统的性能和效率。
2. 责任链模式可能会增加系统的理解难度，不利于代码的维护和理解。

```tsx
abstract class Handler {
  protected successor: Handler;

  public setSuccessor(successor: Handler): void {
    this.successor = successor;
  }

  public abstract handleRequest(request: string): void;
}

class ConcreteHandler1 extends Handler {
  public handleRequest(request: string): void {
    if (request === 'request1') {
      console.log('ConcreteHandler1 handles request1');
    } else if (this.successor) {
      this.successor.handleRequest(request);
    }
  }
}

class ConcreteHandler2 extends Handler {
  public handleRequest(request: string): void {
    if (request === 'request2') {
      console.log('ConcreteHandler2 handles request2');
    } else if (this.successor) {
      this.successor.handleRequest(request);
    }
  }
}

class ConcreteHandler3 extends Handler {
  public handleRequest(request: string): void {
    if (request === 'request3') {
      console.log('ConcreteHandler3 handles request3');
    } else if (this.successor) {
      this.successor.handleRequest(request);
    }
  }
}

const handler1 = new ConcreteHandler1();
const handler2 = new ConcreteHandler2();
const handler3 = new ConcreteHandler3();

handler1.setSuccessor(handler2);
handler2.setSuccessor(handler3);

handler1.handleRequest('request1');
handler1.handleRequest('request2');
handler1.handleRequest('request3');
```

在上面的代码中，我们首先定义了一个抽象处理器类 `Handler` 和多个具体处理器类，每个具体处理器类都可以处理一些请求。然后构建了一个处理链，并将请求传递给处理链的头部，由处理链依次处理请求。在客户端代码中，我们调用了处理链的头部，依次处理请求。

### 命令模式（Command Pattern）

命令模式是一种常见的行为型设计模式，用于将请求封装成对象，并将其传递给调用者，从而实现请求的参数化、队列化、撤销等功能。

在命令模式中，我们定义一个抽象命令类，该类包含一个执行方法和一个撤销方法，具体命令类继承自抽象命令类，实现自己的执行方法和撤销方法。

命令模式的优点在于：

1. 命令模式可以将请求和执行分离，使得代码更加灵活和可扩展。
2. 命令模式可以实现请求的队列化和撤销，从而实现更加复杂的功能。
3. 命令模式可以实现请求的参数化，使得客户端可以灵活地控制请求的执行。

命令模式的缺点在于：

1. 命令模式可能会增加系统的理解难度，不利于代码的维护和理解。
2. 命令模式可能会增加代码的复杂度，特别是在需要实现撤销等功能时。

```tsx
interface Command {
  execute(): void;
  undo(): void;
}

class ConcreteCommand1 implements Command {
  private receiver: Receiver;

  constructor(receiver: Receiver) {
    this.receiver = receiver;
  }

  public execute(): void {
    this.receiver.action1();
  }

  public undo(): void {
    this.receiver.undoAction1();
  }
}

class ConcreteCommand2 implements Command {
  private receiver: Receiver;

  constructor(receiver: Receiver) {
    this.receiver = receiver;
  }

  public execute(): void {
    this.receiver.action2();
  }

  public undo(): void {
    this.receiver.undoAction2();
  }
}

class Receiver {
  public action1(): void {
    console.log('Receiver executes action1');
  }

  public undoAction1(): void {
    console.log('UndoReceiver executes action1');
  }

  public action2(): void {
    console.log('Receiver executes action2');
  }

  public undoAction2(): void {
    console.log('UndoReceiver executes action2');
  }
}

const receiver = new Receiver();
const command1 = new ConcreteCommand1(receiver);
const command2 = new ConcreteCommand2(receiver);

const invoker = new Invoker();
invoker.setCommand(command1);
invoker.executeCommand();
invoker.undoCommand();

invoker.setCommand(command2);
invoker.executeCommand();
invoker.undoCommand();
```

在上面的代码中，我们首先定义了一个抽象命令类 `Command` 和多个具体命令类，每个具体命令类都可以执行一些操作。然后将命令封装成对象，并将其传递给调用者。在客户端代码中，我们构建了一个命令对象，并将其传递给调用者。

### 解释器模式（Interpreter Pattern）

解释器模式是一种常见的行为型设计模式，用于定义一种语言并解释执行该语言中的表达式。核心思想是将语言中的表达式解析成一个抽象语法树，并定义一个解释器，该解释器可以遍历抽象语法树并执行其中的语句。

在解释器模式中，我们定义一个抽象表达式类，该类包含一个解释方法，具体表达式类继承自抽象表达式类，实现自己的解释方法。

解释器模式的优点在于：

1. 解释器模式可以灵活地定义一种语言，并实现该语言的解释器。
2. 解释器模式可以将复杂的语法树分解成简单的语句，从而提高代码的可读性和可维护性。
3. 解释器模式可以实现语言的扩展和变化，特别是在需要频繁添加新的功能时。

解释器模式的缺点在于：

1. 解释器模式可能会导致系统的性能和效率降低，特别是在处理大量数据时。
2. 解释器模式可能会增加系统的理解难度，不利于代码的维护和理解。

```tsx
interface Expression {
  interpret(context: Context): void;
}

class TerminalExpression implements Expression {
  public interpret(context: Context): void {
    console.log('TerminalExpression interprets');
  }
}

class NonterminalExpression implements Expression {
  private expression1: Expression;
  private expression2: Expression;

  constructor(expression1: Expression, expression2: Expression) {
    this.expression1 = expression1;
    this.expression2 = expression2;
  }

  public interpret(context: Context): void {
    console.log('NonterminalExpression interprets');
    this.expression1.interpret(context);
    this.expression2.interpret(context);
  }
}

class Context {
  private input: string;
  private output: string;

  public getInput(): string {
    return this.input;
  }

  public setInput(input: string): void {
    this.input = input;
  }

  public getOutput(): string {
    return this.output;
  }

  public setOutput(output: string): void {
    this.output = output;
  }
}

const context = new Context();

const expression1 = new TerminalExpression();
const expression2 = new TerminalExpression();
const expression3 = new NonterminalExpression(expression1, expression2);

expression3.interpret(context);
```

在上面的代码中，我们首先定义了一个抽象表达式类 `Expression` 和多个具体表达式类，每个具体表达式类都可以解释执行一些语句。然后将语句解析成一个抽象语法树，并定义一个解释器，该解释器可以遍历抽象语法树并执行其中的语句。在客户端代码中，我们构建了一个抽象语法树，并定义了一个解释器，该解释器可以遍历抽象语法树并执行其中的语句。

### 迭代器模式（Iterator Pattern）

迭代器模式是一种行为型设计模式，它允许你在不暴露一个集合对象的内部表示的情况下，按顺序访问该集合中的所有元素。它将遍历一个集合的责任交给了迭代器对象，而不是集合对象本身。

迭代器模式的优点包括：

1. 单一职责原则。将集合对象和遍历逻辑分离，使得它们各自都只负责自己该做的事情。
2. 简化集合接口。不需要在集合中添加各种遍历方法，而是将遍历方法交给迭代器对象。
3. 支持多种遍历方式。可以根据需要创建多个迭代器，每个迭代器都有自己的遍历方式。

迭代器模式的缺点是：

1. 对于简单的集合，使用迭代器模式可能会增加代码复杂性。
2. 在遍历过程中，如果集合发生了变化，可能会导致迭代器失效。

```tsx
interface Iterator<T> {
  next(): T;
  hasNext(): boolean;
}

interface Aggregate<T> {
  createIterator(): Iterator<T>;
}

class ConcreteIterator<T> implements Iterator<T> {
  private collection: T[];
  private position: number = 0;

  constructor(collection: T[]) {
    this.collection = collection;
  }

  public next(): T {
    const result = this.collection[this.position];
    this.position += 1;
    return result;
  }

  public hasNext(): boolean {
    return this.position < this.collection.length;
  }
}

class ConcreteAggregate<T> implements Aggregate<T> {
  private collection: T[] = [];

  public createIterator(): Iterator<T> {
    return new ConcreteIterator(this.collection);
  }

  public addItem(item: T): void {
    this.collection.push(item);
  }
}

// 使用示例
const aggregate = new ConcreteAggregate<number>();
aggregate.addItem(1);
aggregate.addItem(2);
aggregate.addItem(3);

const iterator = aggregate.createIterator();
while (iterator.hasNext()) {
  console.log(iterator.next());
}
```

在这个示例中，我们定义了两个接口 `Iterator` 和 `Aggregate`，分别表示迭代器和集合。然后我们实现了这两个接口的具体类 `ConcreteIterator` 和 `ConcreteAggregate`。其中，`ConcreteIterator` 实现了迭代器接口，`ConcreteAggregate` 实现了集合接口。

在主程序中，我们先创建一个 `ConcreteAggregate` 对象，然后向其中添加了三个元素。接着，我们通过 `createIterator` 方法创建了一个迭代器对象 `iterator`，并在一个 while 循环中用迭代器遍历了整个集合，并输出了每个元素的值。

### 中介者模式（Mediator Pattern）

中介者模式是一种行为型设计模式，它允许你减少对象之间的直接耦合，而是通过一个中介者对象来协调它们的交互。中介者对象允许对象之间以松散的方式进行通信，从而使得系统更容易维护和扩展。

中介者模式的优点包括：

1. 减少耦合度。中介者对象将对象之间的交互从紧密的耦合变成松散的耦合，使得对象之间更容易独立地修改和扩展。
2. 简化对象接口。中介者对象可以封装对象之间的交互，使得对象只需要了解中介者对象的接口，而不需要了解其他对象的接口。
3. 提供可重用的模块。中介者对象可以作为可重用的组件，可以在不同的对象之间共享，从而避免重复编写代码。

中介者模式的缺点是：

1. 中介者对象可能会变得过于复杂。如果中介者对象负责过多的对象之间的交互，它可能会变得过于复杂和难以维护。
2. 中介者对象可能成为系统的瓶颈。如果中介者对象负责太多的对象之间的交互，它可能会成为系统的瓶颈，导致系统的性能下降。

```tsx
interface Mediator {
  notify(sender: Colleague, event: string): void;
}

abstract class Colleague {
  protected mediator: Mediator;

  constructor(mediator: Mediator) {
    this.mediator = mediator;
  }

  public abstract send(event: string): void;

  public abstract receive(event: string): void;
}

class ConcreteColleagueA extends Colleague {
  public send(event: string): void {
    console.log(`Colleague A sends event ${event}`);
    this.mediator.notify(this, event);
  }

  public receive(event: string): void {
    console.log(`Colleague A receives event ${event}`);
  }
}

class ConcreteColleagueB extends Colleague {
  public send(event: string): void {
    console.log(`Colleague B sends event ${event}`);
    this.mediator.notify(this, event);
  }

  public receive(event: string): void {
    console.log(`Colleague B receives event ${event}`);
  }
}

class ConcreteMediator implements Mediator {
  private colleagueA: ConcreteColleagueA;
  private colleagueB: ConcreteColleagueB;

  public setColleagueA(colleagueA: ConcreteColleagueA): void {
    this.colleagueA = colleagueA;
  }

  public setColleagueB(colleagueB: ConcreteColleagueB): void {
    this.colleagueB = colleagueB;
  }

  public notify(sender: Colleague, event: string): void {
    if (sender === this.colleagueA) {
      this.colleagueB.receive(event);
    } else if (sender === this.colleagueB) {
      this.colleagueA.receive(event);
    }
  }
}

// 使用示例
const mediator = new ConcreteMediator();

const colleagueA = new ConcreteColleagueA(mediator);
const colleagueB = new ConcreteColleagueB(mediator);

mediator.setColleagueA(colleagueA);
mediator.setColleagueB(colleagueB);

colleagueA.send("Hello, colleague B!");
colleagueB.send("Hi, colleague A!");
```

在这个示例中，我们定义了三个类 `Colleague`、`ConcreteColleagueA` 和 `ConcreteColleagueB`，分别表示同事和具体同事对象。其中，`Colleague` 是一个抽象类，定义了同事类的基本行为，而 `ConcreteColleagueA` 和 `ConcreteColleagueB` 则是具体的同事类。

我们还定义了一个类 `Mediator`，表示中介者对象。中介者对象通过 `notify` 方法接收同事对象发送的事件，并将该事件发送给其他同事对象。

在主程序中，我们先创建了一个 `ConcreteMediator` 对象，并分别将它的 `colleagueA` 和 `colleagueB` 属性设置为 `ConcreteColleagueA` 和 `ConcreteColleagueB` 对象。接着，我们用 `send` 方法向同事对象发送事件，并在 `receive` 方法中接收它们。

### 备忘录模式（Memento Pattern）

备忘录模式是一种行为型设计模式，它允许你在不破坏对象封装的前提下，捕获对象的内部状态，并在需要时恢复该状态。备忘录模式通常与命令模式或者撤销操作一起使用。

备忘录模式的优点包括：

1. 封装了对象状态。备忘录对象允许你在对象之外保存和恢复对象状态，而不需要暴露该状态的实现细节。
2. 简化了恢复操作。备忘录对象可以轻松地保存和恢复对象状态，从而简化了恢复操作的实现。
3. 支持多次撤销操作。备忘录对象可以保存多个状态，从而支持多次撤销操作。

备忘录模式的缺点是：

1. 可能会增加内存开销。备忘录对象保存了对象的状态，可能会占用大量的内存空间。
2. 可能会降低性能。每次保存和恢复对象状态都需要进行一些额外的操作，可能会影响系统的性能。

```tsx
interface Memento {
  getState(): string;
}

class ConcreteMemento implements Memento {
  private state: string;

  constructor(state: string) {
    this.state = state;
  }

  public getState(): string {
    return this.state;
  }
}

class Originator {
  private state: string;

  constructor(state: string) {
    this.state = state;
  }

  public setState(state: string): void {
    console.log(`Originator: Setting state to ${state}`);
    this.state = state;
  }

  public save(): Memento {
    console.log(`Originator: Saving state ${this.state}`);
    return new ConcreteMemento(this.state);
  }

  public restore(memento: Memento): void {
    this.state = memento.getState();
    console.log(`Originator: Restoring state to ${this.state}`);
  }
}

class Caretaker {
  private mementos: Memento[] = [];
  private originator: Originator;

  constructor(originator: Originator) {
    this.originator = originator;
  }

  public backup(): void {
    console.log("Caretaker: Saving Originator's state...");
    this.mementos.push(this.originator.save());
  }

  public undo(): void {
    if (this.mementos.length === 0) {
      console.log("Caretaker: There is no saved state.");
      return;
    }
    const memento = this.mementos.pop();
    console.log(`Caretaker: Restoring state to ${memento.getState()}`);
    this.originator.restore(memento);
  }
}

// 使用示例
const originator = new Originator("state 1");

const caretaker = new Caretaker(originator);

caretaker.backup();

originator.setState("state 2");

caretaker.backup();

originator.setState("state 3");

caretaker.undo();
caretaker.undo();
```

在这个示例中，我们定义了三个类 `Memento`、`ConcreteMemento` 和 `Originator`，分别表示备忘录、具体备忘录和原发器。其中，`Memento` 定义了备忘录对象的接口，`ConcreteMemento` 实现了备忘录接口，`Originator` 是我们要保存和恢复状态的对象。

我们还定义了一个类 `Caretaker`，表示负责保存和恢复备忘录的对象。在 `Caretaker` 类中，我们使用一个数组 `mementos` 来保存备忘录对象。`backup` 方法用于将当前状态保存到备忘录中，而 `undo` 方法用于恢复最近一次保存的状态。

在主程序中，我们先创建了一个 `Originator` 对象，并将它的状态设置为 "state 1"。接着，我们创建了一个 `Caretaker` 对象，并通过 `backup` 方法将当前状态保存到备忘录中。然后，我们将 `Originator` 对象的状态分别设置为 "state 2" 和 "state 3"。最后，我们使用 `undo` 方法恢复了之前的两个状态。

### 观察者模式（Observer Pattern）

观察者模式是一种行为型设计模式，它允许你定义一种一对多的依赖关系，使得多个对象之间可以通过观察者对象的方式自动通知和更新。当一个对象发生改变时，它的所有依赖对象都会收到通知并自动更新。

观察者模式的优点包括：

1. 松耦合。观察者模式允许对象之间松散地耦合，从而使得这些对象之间的依赖关系更加灵活和可扩展。
2. 可重用性。观察者模式允许你将观察者对象和被观察者对象分离，使得它们可以独立地被修改和重用。
3. 通用性。观察者模式是一种通用的设计模式，它可以应用于各种不同的场景和领域。

观察者模式的缺点是：

1. 可能会导致性能问题。当被观察者对象发生改变时，它需要通知所有的观察者对象，这可能会导致性能问题。
2. 可能会导致复杂性。如果观察者模式的实现不当，它可能会导致过多的依赖关系和复杂性。

```tsx
interface Observer {
  update(subject: Subject): void;
}

class Subject {
  private observers: Observer[] = [];

  public attach(observer: Observer): void {
    console.log("Subject: Attached an observer.");
    this.observers.push(observer);
  }

  public detach(observer: Observer): void {
    const index = this.observers.indexOf(observer);
    this.observers.splice(index, 1);
    console.log("Subject: Detached an observer.");
  }

  public notify(): void {
    console.log("Subject: Notifying observers...");
    for (const observer of this.observers) {
      observer.update(this);
    }
  }
}

class ConcreteObserverA implements Observer {
  public update(subject: Subject): void {
    console.log("ConcreteObserverA: Reacted to the event.");
  }
}

class ConcreteObserverB implements Observer {
  public update(subject: Subject): void {
    console.log("ConcreteObserverB: Reacted to the event.");
  }
}

// 使用示例
const subject = new Subject();

const observer1 = new ConcreteObserverA();
const observer2 = new ConcreteObserverB();

subject.attach(observer1);
subject.attach(observer2);

subject.notify();

subject.detach(observer2);

subject.notify();
```

在这个示例中，我们定义了三个类 `Observer`、`Subject` 和具体观察者类 `ConcreteObserverA` 和 `ConcreteObserverB`，分别表示观察者、被观察者和具体观察者对象。其中，`Observer` 定义了观察者对象的接口，`Subject` 是我们要观察的对象。

我们还定义了两个具体观察者类 `ConcreteObserverA` 和 `ConcreteObserverB`，它们实现了 `Observer` 接口中的 `update` 方法。在 `Subject` 类中，我们使用一个数组 `observers` 来保存观察者对象。`attach` 方法用于向数组中添加观察者对象，`detach` 方法用于从数组中删除观察者对象，`notify` 方法用于通知所有的观察者对象。

在主程序中，我们先创建了一个 `Subject` 对象。然后，我们创建了一个 `ConcreteObserverA` 和一个 `ConcreteObserverB` 对象，并通过 `attach` 方法将它们添加到 `Subject` 对象的观察者数组中。接着，我们调用 `notify` 方法通知所有的观察者对象。最后，我们通过 `detach` 方法从 `Subject` 对象的观察者数组中删除了 `ConcreteObserverB` 对象，并再次调用了 `notify` 方法。

### 状态模式（State Pattern）

状态模式是一种行为型设计模式，它允许对象在内部状态变化时改变它的行为。在状态模式中，我们将一个对象的行为和状态分离开来，使得状态的改变不影响对象的行为。这样可以让代码更加灵活、可扩展和易于维护。

状态模式包含以下几个角色：

- Context：上下文，它负责维护一个 State 对象，并将所有请求委托给该对象处理。
- State：状态，它定义了一个接口，用于处理上下文的请求，并且可以参与状态的转移。
- ConcreteState：具体状态，它实现了 State 接口，并处理与状态相关的请求。

状态模式的优点包括：

- 将状态的判断和转移封装到具体状态类中，使得状态的改变更加容易，同时也使得状态转移的代码更加清晰和易于维护。
- 将大量的条件语句转化为状态类，可以提高代码的可读性和可维护性，并且可以让代码更加灵活和可扩展。

状态模式的缺点包括：

- 增加了类的数量，可能会增加系统的复杂度。
- 如果状态转移比较复杂，可能会导致状态类之间的相互依赖，使得代码更加难以理解和维护。

```tsx
// State 接口
interface LightState {
  switch(): void;
}

// ConcreteState：开灯状态
class OnState implements LightState {
  switch() {
    console.log("灯已经打开了");
  }
}

// ConcreteState：关灯状态
class OffState implements LightState {
  switch() {
    console.log("灯已经关闭了");
  }
}

// Context：电灯类
class Light {
  private state: LightState;

  constructor() {
    // 初始化为关灯状态
    this.state = new OffState();
  }

  setState(state: LightState) {
    this.state = state;
  }

  switch() {
    this.state.switch();
  }
}

// 使用示例
const light = new Light();

light.switch(); // 灯已经关闭了

light.setState(new OnState());
light.switch(); // 灯已经打开了

light.setState(new OffState());
light.switch(); // 灯已经关闭了
```

在这个例子中，我们定义了一个 `Light` 类来代表电灯，同时定义了 `LightState` 接口和两个具体状态类来处理电灯的开和关状态。在 `Light` 类中，我们通过维护一个 `state` 属性来表示当前的状态，并将所有请求委托给它来处理。

在具体状态类中，我们实现了 `LightState` 接口，并处理与状态相关的请求。例如，在 `OnState` 中，我们实现了 `switch` 方法，并输出了灯已经打开了的信息。

在使用状态模式时，我们可以将状态类作为参数传递给上下文类，或者使用工厂模式来创建状态类。这样可以使得状态的改变更加方便和灵活，同时也使得代码更加易于维护和扩展。

### 策略模式（Strategy Pattern）

策略模式是一种行为型设计模式，它定义了一系列算法，并将每个算法封装起来，使得它们可以相互替换。在策略模式中，我们可以在运行时动态地选择算法，从而改变一个对象的行为。

策略模式包含以下几个角色：

- Context：上下文，它定义了一个接口，用于与客户端进行交互，并且维护一个对 Strategy 对象的引用。
- Strategy：策略，它定义了一个接口，用于封装具体的算法。
- ConcreteStrategy：具体策略，它实现了 Strategy 接口，并提供了具体的算法实现。

策略模式的优点包括：

- 提供了一种灵活的方式来动态地改变对象的行为。
- 可以将算法的实现与使用算法的客户端代码分离开来，使得代码更加清晰、简洁和易于维护。
- 可以对算法进行封装，使得算法的变化不会对客户端代码造成影响。

策略模式的缺点包括：

- 增加了类的数量，可能会增加系统的复杂度。
- 客户端需要了解所有的策略类，选择合适的策略类可能会增加客户端代码的复杂度。

```tsx
// Strategy 接口
interface CalculatorStrategy {
  calculate(a: number, b: number): number;
}

// ConcreteStrategy：加法
class AddStrategy implements CalculatorStrategy {
  calculate(a: number, b: number) {
    return a + b;
  }
}

// ConcreteStrategy：减法
class SubtractStrategy implements CalculatorStrategy {
  calculate(a: number, b: number) {
    return a - b;
  }
}

// ConcreteStrategy：乘法
class MultiplyStrategy implements CalculatorStrategy {
  calculate(a: number, b: number) {
    return a * b;
  }
}

// ConcreteStrategy：除法
class DivideStrategy implements CalculatorStrategy {
  calculate(a: number, b: number) {
    return a / b;
  }
}

// Context：计算器类
class Calculator {
  private strategy: CalculatorStrategy;

  constructor() {
    // 初始化为加法策略
    this.strategy = new AddStrategy();
  }

  setStrategy(strategy: CalculatorStrategy) {
    this.strategy = strategy;
  }

  calculate(a: number, b: number) {
    return this.strategy.calculate(a, b);
  }
}

// 使用示例
const calculator = new Calculator();

console.log(calculator.calculate(1, 2)); // 3

calculator.setStrategy(new SubtractStrategy());
console.log(calculator.calculate(3, 2)); // 1

calculator.setStrategy(new MultiplyStrategy());
console.log(calculator.calculate(2, 3)); // 6

calculator.setStrategy(new DivideStrategy());
console.log(calculator.calculate(6, 3)); // 2
```

在这个示例中，我们定义了一个 `Calculator` 类来代表计算器，同时定义了 `CalculatorStrategy` 接口和四个具体策略类来处理加、减、乘和除四种运算。在 `Calculator` 类中，我们通过维护一个 `strategy` 属性来表示当前的策略，并将所有计算请求委托给它来处理。

在具体策略类中，我们实现了 `CalculatorStrategy` 接口，并处理具体的算法实现。例如，在 `AddStrategy` 中，我们实现了 `calculate` 方法，并返回两个数的和。

在使用策略模式时，我们可以在运行时动态地选择算法，从而改变对象的行为。例如，在使用计算器时，我们可以通过调用 `setStrategy` 方法来更改当前的策略，从而进行不同的运算。

### 模板方法模式（Template Method Pattern）

模板方法模式是一种行为型设计模式，它定义了一个算法的框架，并允许子类在不改变算法结构的情况下重新定义算法中的某些步骤。在模板方法模式中，我们将算法的结构抽象出来，将具体的实现延迟到子类中。

模板方法模式包含以下几个角色：

- AbstractClass：抽象类，它定义了一组抽象的算法步骤，并且定义了一个模板方法，用于控制算法的执行顺序。
- ConcreteClass：具体类，它实现了 AbstractClass 中定义的算法步骤，同时可以重写其中的某些步骤，以实现特定的行为。

模板方法模式的优点包括：

- 提供了一种简单的方式来重用代码，同时可以更容易地扩展和修改算法。
- 可以将算法的实现细节隐藏在抽象类中，使得客户端代码不需要知道这些细节。
- 可以通过子类来实现不同的算法步骤，从而灵活地定制算法的行为。

模板方法模式的缺点包括：

- 可能会导致类的数量增加，从而增加系统的复杂度。
- 可能会将算法的步骤强制固定在抽象类中，使得算法的灵活性受到限制。

```tsx
// AbstractClass：车辆类
abstract class Vehicle {
  // 模板方法
  run() {
    this.refuel();
    this.start();
    this.drive();
    this.stop();
  }

  // 抽象方法：加油
  abstract refuel(): void;

  // 具体方法：启动
  start() {
    console.log("车辆启动");
  }

  // 抽象方法：行驶
  abstract drive(): void;

  // 具体方法：停车
  stop() {
    console.log("车辆停车");
  }
}

// ConcreteClass：汽车类
class Car extends Vehicle {
  refuel() {
    console.log("汽车加油");
  }

  drive() {
    console.log("汽车行驶");
  }
}

// ConcreteClass：卡车类
class Truck extends Vehicle {
  refuel() {
    console.log("卡车加油");
  }

  drive() {
    console.log("卡车行驶");
  }
}

// 使用示例
const car = new Car();
car.run(); // 汽车加油、车辆启动、汽车行驶、车辆停车

const truck = new Truck();
truck.run(); // 卡车加油、车辆启动、卡车行驶、车辆停车
```

在这个示例中，我们定义了一个抽象类 `Vehicle` 来代表车辆，同时定义了一个模板方法 `run` 和四个抽象方法 `refuel`、`drive`、`start` 和 `stop`。

在具体类中，我们继承了 `Vehicle` 类，并实现了其中的抽象方法。例如，在 `Car` 中，我们实现了 `refuel` 和 `drive` 方法，并输出了汽车加油和汽车行驶的信息。

在使用模板方法模式时，我们可以通过重写抽象方法来实现不同的算法步骤，并通过调用模板方法来执行算法。例如，在使用 `Car` 类时，我们可以调用 `run` 方法来执行汽车的加油、启动、行驶和停车的操作。

### 访问者模式（Visitor Pattern）

访问者模式是一种行为型设计模式，它可以在不改变被访问对象的结构的情况下，定义对这些对象的新操作。在访问者模式中，我们将操作封装在访问者对象中，通过将访问者对象传递给被访问对象，从而实现对被访问对象的访问。

访问者模式包含以下几个角色：

- Visitor：访问者，它定义了一组访问操作，可以访问不同类型的元素。
- ConcreteVisitor：具体访问者，它实现了 Visitor 中定义的访问操作。
- Element：元素，它定义了一个接受访问者的接口，用于接受访问者的访问。
- ConcreteElement：具体元素，它实现了 Element 中定义的接受访问者的接口，并将自身作为参数传递给访问者。
- ObjectStructure：对象结构，它维护了一个元素集合，并提供了访问元素集合的接口。

访问者模式的优点包括：

- 可以将新的操作封装在访问者对象中，从而避免对被访问对象的修改。
- 可以通过访问者对象来实现新的操作，从而增加系统的灵活性和可扩展性。
- 可以将相关的操作集中在访问者对象中，使得代码更加清晰、易于维护和扩展。

访问者模式的缺点包括：

- 增加了系统的复杂度，可能会增加代码的阅读和理解难度。
- 在访问者对象中添加新的操作可能会导致访问者对象变得臃肿和复杂。

```tsx
// Visitor 接口
interface Visitor {
  visitA(element: ElementA): void;
  visitB(element: ElementB): void;
}

// ConcreteVisitor：访问者A
class VisitorA implements Visitor {
  visitA(element: ElementA) {
    console.log("访问者A访问ElementA");
  }

  visitB(element: ElementB) {
    console.log("访问者A访问ElementB");
  }
}

// ConcreteVisitor：访问者B
class VisitorB implements Visitor {
  visitA(element: ElementA) {
    console.log("访问者B访问ElementA");
  }

  visitB(element: ElementB) {
    console.log("访问者B访问ElementB");
  }
}

// Element 接口
interface Element {
  accept(visitor: Visitor): void;
}

// ConcreteElement：元素A
class ElementA implements Element {
  accept(visitor: Visitor) {
    visitor.visitA(this);
  }
}

// ConcreteElement：元素B
class ElementB implements Element {
  accept(visitor: Visitor) {
    visitor.visitB(this);
  }
}

// ObjectStructure：对象结构
class ObjectStructure {
  private elements: Element[] = [];

  addElement(element: Element) {
    this.elements.push(element);
  }

  removeElement(element: Element) {
    const index = this.elements.indexOf(element);
    if (index !== -1) {
      this.elements.splice(index, 1);
    }
  }

  accept(visitor: Visitor) {
    this.elements.forEach(element => {
      element.accept(visitor);
    });
  }
}

// 使用示例
const objectStructure = new ObjectStructure();
objectStructure.addElement(new ElementA());
objectStructure.addElement(new ElementB());

const visitorA = new VisitorA();
const visitorB = new VisitorB();

objectStructure.accept(visitorA);
// 输出：
// 访问者A访问ElementA
// 访问者A访问ElementB

objectStructure.accept(visitorB);
// 输出：
// 访问者B访问ElementA
// 访问者B访问ElementB
```

在这个示例中，我们定义了一个访问者接口 `Visitor` 和两个具体访问者类 `VisitorA` 和 `VisitorB`，用于访问不同类型的元素。

在元素接口 `Element` 中，我们定义了一个 `accept` 方法，用于接受访问者的访问。在具体元素类 `ElementA` 和 `ElementB` 中，我们实现了 `accept` 方法，并将自身作为参数传递给访问者。

在对象结构类 `ObjectStructure` 中，我们维护了一个元素集合，并提供了访问元素集合的接口。在 `accept` 方法中，我们遍历元素集合，并将访问者对象传递给每个元素。

在使用访问者模式时，我们可以通过定义不同的访问者对象来实现新的操作。例如，在使用 `VisitorA` 类时，我们可以访问元素集合，并对其中的元素进行操作。在使用 `ObjectStructure` 类时，我们可以动态地添加或删除元素，从而灵活地控制元素的访问。

## 架构模式

架构模式用于处理系统整体架构的问题。

### 分层架构（Layered Architecture）

分层架构是一种将应用程序划分为多个层次的软件设计模式。每个层次都代表了特定的功能和职责，并且层与层之间的依赖关系是单向的。分层架构通常包括以下几个层次：

1. 表现层（Presentation Layer）：该层负责用户界面的显示和交互，通常使用的技术包括HTML、CSS、JavaScript等。
2. 应用层（Application Layer）：该层负责应用程序的逻辑处理，包括数据验证、数据转换、业务规则等。
3. 领域层（Domain Layer）：该层负责定义应用程序的业务逻辑和领域模型。它是整个应用程序的核心，包括实体、值对象、仓储、服务等。
4. 基础设施层（Infrastructure Layer）：该层负责提供应用程序所需的基础设施，包括数据库、文件系统、网络通信等。

分层架构的优点：

1. 易于理解和维护：每个层次都有清晰的职责和功能，易于理解和维护。
2. 可扩展性强：每个层次都可以独立地进行扩展和修改，不会影响其他层次。
3. 可测试性强：每个层次都可以进行单元测试和集成测试，提高了应用程序的质量和可靠性。

```tsx
// 领域层
class User {
  constructor(public id: number, public name: string) {}
}

interface UserRepository {
  getById(id: number): Promise<User>;
  save(user: User): Promise<void>;
}

// 基础设施层
class InMemoryUserRepository implements UserRepository {
  private users: User[] = [];

  async getById(id: number): Promise<User> {
    const user = this.users.find((u) => u.id === id);
    if (!user) {
      throw new Error("User not found");
    }
    return user;
  }

  async save(user: User): Promise<void> {
    const existingUserIndex = this.users.findIndex((u) => u.id === user.id);
    if (existingUserIndex >= 0) {
      this.users[existingUserIndex] = user;
    } else {
      this.users.push(user);
    }
  }
}

// 应用层
class UserService {
  constructor(private userRepository: UserRepository) {}

  async getUserById(id: number): Promise<User> {
    return this.userRepository.getById(id);
  }

  async saveUser(user: User): Promise<void> {
    return this.userRepository.save(user);
  }
}

// 表现层
const userRepository = new InMemoryUserRepository();
const userService = new UserService(userRepository);

async function getUser(id: number): Promise<void> {
  try {
    const user = await userService.getUserById(id);
    console.log(`User: ${user.id}, ${user.name}`);
  } catch (error) {
    console.error(error.message);
  }
}

async function saveUser(id: number, name: string): Promise<void> {
  const user = new User(id, name);
  await userService.saveUser(user);
  console.log("User saved successfully");
}

getUser(1);
saveUser(2, "Alice");
```

在这个示例中，我们使用 TypeScript 实现了一个简单的分层架构。该应用程序包括四个层次：领域层、基础设施层、应用层和表现层。每个层次都有清晰的职责和功能，并且层与层之间的依赖关系是单向的。

在领域层，我们定义了 User 实体和 UserRepository 接口，以及一个 InMemoryUserRepository 的实现。

在基础设施层，我们实现了 UserRepository 接口的 InMemoryUserRepository 类，用于保存和获取用户数据。

在应用层，我们实现了 UserService 类，用于提供获取和保存用户数据的功能。

在表现层，我们使用 UserService 类提供的功能，实现了 getUser 和 saveUser 两个函数，用于获取和保存用户数据。

### 客户端-服务器架构（Client-Server Architecture）

客户端-服务器架构是一种将应用程序划分为两部分的架构，分别是客户端和服务器。客户端负责提供用户界面和交互，服务器负责处理业务逻辑和数据存储。客户端和服务器之间通过网络通信进行数据交换。客户端-服务器架构通常包括以下几个组件：

1. 客户端（Client）：该组件负责提供用户界面和交互，通常使用的技术包括HTML、CSS、JavaScript等。
2. 服务器（Server）：该组件负责处理业务逻辑和数据存储，通常使用的技术包括各种编程语言和数据库。
3. 网络（Network）：该组件负责客户端和服务器之间的数据传输和通信，通常使用的协议包括HTTP、TCP等。

客户端-服务器架构的优点：

1. 可扩展性强：客户端和服务器可以独立进行扩展和修改，不会影响对方。
2. 安全性高：服务器可以对客户端请求进行数据验证和身份验证，保证数据的安全性。
3. 性能高：可以通过服务器端的缓存和负载均衡等技术，提高应用程序的性能和可靠性。

客户端-服务器架构的缺点：

1. 可能会增加代码的复杂性：客户端和服务器之间需要进行数据传输和通信，可能会增加代码的复杂性和开发成本。
2. 可能会影响应用程序的响应速度：客户端和服务器之间需要进行网络通信，可能会影响应用程序的响应速度。

### 分布式系统架构（Distributed Systems Architecture）

分布式系统架构是一种将应用程序划分为多个独立的组件，这些组件可以在不同的计算机节点上运行，并且通过网络通信进行数据交换和协同工作。分布式系统架构通常包括以下几个组件：

1. 服务节点（Service Nodes）：该组件负责提供特定的服务，例如数据库服务、消息队列服务、缓存服务等。
2. 通信协议（Communication Protocols）：该组件负责定义服务节点之间的通信协议，例如REST、gRPC等。
3. 负载均衡器（Load Balancers）：该组件负责将请求分配到不同的服务节点上，以实现负载均衡和高可用性。
4. 集群管理器（Cluster Managers）：该组件负责管理和协调不同服务节点之间的工作，以实现分布式系统的一致性和可靠性。

分布式系统架构的优点：

1. 可扩展性强：分布式系统可以根据需求进行动态扩展和缩减，以适应不同的负载情况。
2. 可靠性高：分布式系统可以通过复制和备份等技术，提高系统的可靠性和容错性。
3. 性能高：分布式系统可以通过分散计算和负载均衡等技术，提高系统的性能和吞吐量。

分布式系统架构的缺点：

1. 可能会增加代码的复杂性：分布式系统需要处理分布式环境下的各种复杂问题，例如网络延迟、节点故障等，可能会增加代码的复杂性和开发成本。
2. 可能会影响应用程序的响应速度：分布式系统需要进行数据传输和通信，可能会影响应用程序的响应速度。

### 微服务架构（Microservices Architecture）

微服务架构是一种将应用程序划分为多个小型、独立的服务，每个服务都可以单独部署和运行，并且通过轻量级的通信机制进行协同工作。微服务架构通常包括以下几个组件：

1. 微服务（Microservices）：该组件负责提供特定的服务，例如用户服务、订单服务、支付服务等。
2. 通信协议（Communication Protocols）：该组件负责定义微服务之间的通信协议，例如REST、gRPC等。
3. API网关（API Gateway）：该组件负责将客户端请求转发到不同的微服务上，以实现服务的聚合和路由。
4. 服务注册与发现（Service Registry and Discovery）：该组件负责管理和发现不同微服务的位置和状态，以实现服务的动态发现和调用。

微服务架构的优点：

1. 可扩展性强：微服务可以根据需求进行动态扩展和缩减，以适应不同的负载情况。
2. 可靠性高：微服务可以通过复制和备份等技术，提高系统的可靠性和容错性。
3. 灵活性高：微服务可以使用不同的编程语言和技术栈，以适应不同的业务需求和技术发展。
4. 易于维护和升级：微服务可以独立部署和运行，可以快速进行维护和升级，同时不会影响其他微服务的正常工作。

微服务架构的缺点：

1. 可能会增加代码的复杂性：微服务需要处理分布式环境下的各种复杂问题，例如服务治理、服务路由等，可能会增加代码的复杂性和开发成本。
2. 可能会影响应用程序的响应速度：微服务需要进行数据传输和通信，可能会影响应用程序的响应速度。

### 事件驱动架构（Event-Driven Architecture）

事件驱动架构（Event-Driven Architecture，EDA）是一种基于事件和消息的系统架构，它通过事件的发布、订阅和处理，实现不同组件之间的解耦、松散耦合和高效协作。事件驱动架构通常包括以下几个组件：

1. 事件（Event）：该组件代表系统中的某个状态或者操作，例如订单创建、用户登录、商品下架等。
2. 消息队列（Message Queue）：该组件负责存储和传递事件消息，以实现事件的异步、可靠和高效处理。
3. 事件处理器（Event Processor）：该组件负责订阅、处理和发布事件消息，以实现事件的逻辑处理和状态更新。

事件驱动架构的优点：

1. 解耦性强：事件驱动架构可以将不同组件之间的耦合度降到最低，以实现系统的高度解耦和灵活性。
2. 可扩展性强：事件驱动架构可以通过水平扩展和分布式部署，以实现系统的高度可伸缩性和容错性。
3. 可靠性高：事件驱动架构可以使用消息队列等技术，以实现事件的异步和可靠处理，同时保证系统的数据一致性和可用性。
4. 易于维护和升级：事件驱动架构可以使用事件驱动的方式实现系统的业务逻辑，以实现系统的易于维护和升级。

事件驱动架构的缺点：

1. 可能会增加代码的复杂性：事件驱动架构需要处理异步事件和消息传递等复杂问题，可能会增加代码的复杂性和开发成本。
2. 可能会影响应用程序的响应速度：事件驱动架构需要进行数据传输和通信，可能会影响应用程序的响应速度。

```tsx
class EventEmitter {
  private events: { [key: string]: Function[] };

  constructor() {
    this.events = {};
  }

  on(eventName: string, listener: Function) {
    if (!this.events[eventName]) {
      this.events[eventName] = [];
    }
    this.events[eventName].push(listener);
  }

  emit(eventName: string, ...args: any[]) {
    const listeners = this.events[eventName];
    if (listeners) {
      listeners.forEach((listener) => listener(...args));
    }
  }
}

// 示例
const eventEmitter = new EventEmitter();

eventEmitter.on('eventName', (arg1: string, arg2: number) => {
  console.log(`Event triggered with ${arg1} and ${arg2}`);
});

eventEmitter.emit('eventName', 'hello', 123);
```

### RESTful 架构（RESTful Architecture）

RESTful 架构（Representational State Transfer）是一种基于 HTTP 协议的 Web 应用程序架构，它通过定义资源、标识符、操作和状态等概念，实现 Web 应用程序的统一接口和资源的统一访问。RESTful 架构通常包括以下几个组件：

1. 资源（Resource）：该组件代表 Web 应用程序中的某个实体或者信息，例如用户、文章、评论等。
2. 标识符（Identifier）：该组件代表资源的唯一标识符，例如 URL、URI 等。
3. 操作（Method）：该组件代表对资源进行的操作，例如 GET、POST、PUT、DELETE 等。
4. 状态（Status）：该组件代表 Web 应用程序的状态信息，例如 HTTP 状态码、响应头等。

RESTful 架构的优点：

1. 可读性强：RESTful 架构使用 HTTP 协议的 GET、POST、PUT、DELETE 等方法和状态码，使得 Web 应用程序的接口具有可读性和易于理解性。
2. 可缓存性强：RESTful 架构使用 HTTP 协议的缓存机制，使得 Web 应用程序的访问速度更快、性能更好。
3. 松散耦合性强：RESTful 架构将资源和操作进行了明确的定义和分离，使得 Web 应用程序的组件之间具有松散耦合性，易于扩展和维护。
4. 可移植性强：RESTful 架构使用标准的 HTTP 协议和格式，使得 Web 应用程序的接口具有可移植性和互操作性。

RESTful 架构的缺点：

1. 可能会增加代码的复杂性：RESTful 架构需要考虑资源、标识符、操作和状态等多个概念，可能会增加代码的复杂性和开发成本。
2. 可能会影响应用程序的性能：RESTful 架构需要使用 HTTP 协议进行通信，可能会影响应用程序的性能和响应速度。

## 并发模式（Concurrency Patterns）

并发模式用于处理多线程和并发编程的问题。

### 锁模式（Lock Pattern）

锁模式是一种常见的并发模式，用于实现多线程之间的同步和互斥访问。锁模式通常涉及一个或多个锁对象，用于控制多个线程之间的访问和操作。

锁模式可以分为两类：互斥锁模式和共享锁模式。

1. 互斥锁模式：互斥锁模式用于控制多个线程之间的互斥访问，以保证共享资源的一致性和可靠性。在互斥锁模式中，只有一个线程可以获取锁对象，其他线程必须等待锁对象被释放后才能获取锁对象。互斥锁模式通常使用 synchronized 关键字或 Lock 接口实现。
2. 共享锁模式：共享锁模式用于控制多个线程之间的共享访问，以提高并发访问性能和可伸缩性。在共享锁模式中，多个线程可以同时获取同一个锁对象，以便并发访问共享资源。共享锁模式通常使用读写锁（Read-Write Lock）或信号量（Semaphore）实现。

锁模式的优势在于，它可以保证共享资源的一致性和可靠性，避免多个线程之间的竞争和冲突问题。同时，锁模式也可以提高多线程程序的性能和可伸缩性，允许多个线程同时访问共享资源，从而提高并发性能和吞吐量。

需要注意的是，锁模式的实现需要考虑多个方面的因素，例如锁的粒度、锁的可重入性、死锁和饥饿问题等。程序员需要根据实际情况选择合适的锁模式，并结合其他并发模式和技术进行设计和实现。

### 读写锁模式（Read-Write Lock Pattern）

读写锁模式是一种常见的并发模式，用于解决多线程读写共享资源的问题。在读写锁模式中，共享资源可以被多个线程同时读取，但只能被一个线程写入。读写锁模式通过控制读锁和写锁的获取，实现了对共享资源的并发访问控制。

读写锁模式通常包括以下几个组成部分：

1. 读锁：多个线程可以同时获取读锁，以便并发读取共享资源。
2. 写锁：只有一个线程可以获取写锁，以便独占式地写入共享资源。
3. 锁状态：读写锁维护一个锁状态，用于记录当前读锁和写锁的获取情况。
4. 读优先或写优先：读写锁可以根据实际情况选择读优先或写优先的策略，以便更好地满足应用程序的需求。

读写锁模式的优势在于，它可以提高共享资源的并发性能和可伸缩性，允许多个线程同时读取共享资源，从而避免了竞争和瓶颈问题。同时，由于写锁是独占式的，读写锁模式也可以保证共享资源的一致性和可靠性。

在 Java 中，读写锁模式通常使用 ReentrantReadWriteLock 类实现。ReentrantReadWriteLock 类提供了读锁和写锁的获取和释放方法，以及读锁和写锁的升级和降级操作，使得读写锁模式的实现更加灵活和高效。

需要注意的是，读写锁模式的实现需要根据实际情况进行调整和优化，以避免死锁、饥饿等问题，并结合其他并发模式和技术进行设计和实现。

### 同步模式（Synchronization Pattern）

同步模式是一种简单的编程模式，它要求代码在执行某个操作时必须等待该操作完成才能继续往下执行。这种模式是一种阻塞式的模式，它的优点是代码可以简单易懂，缺点是过多的阻塞会导致应用的性能瓶颈。

同步模式的优点是代码可读性强，流程清晰明了，易于调试。缺点是代码执行速度慢，一旦阻塞就会导致整个应用程序挂起，造成性能问题。

### 异步模式（Asynchronous Patterns）

异步模式是一种编程模式，它允许程序在等待某些操作结果时继续执行其他任务，而不是阻塞在当前操作上。这种模式通常用于处理网络请求、文件读取、定时器等需要等待结果的任务。

异步模式的优点包括：

1. 不会阻塞程序的执行，可以提高程序的响应速度和并发度。
2. 可以更好地处理大量的并发请求。
3. 可以提高程序的可靠性和稳定性。

异步模式的缺点包括：

1. 代码可读性较差，需要掌握一定的异步编程技巧。
2. 需要处理回调函数中可能出现的错误。
3. 对于一些简单的任务，异步模式可能会增加代码的复杂度。

### 并发访问模式（Concurrent Access Patterns）

并发访问模式是一种设计模式，用于在多个线程或进程同时访问共享资源时，确保数据同步性和一致性的方法。

此模式的优点包括：

1. 提高应用性能，允许多个用户同时访问相同的资源。
2. 提高系统可靠性，确保多个线程或进程之间的数据同步和一致性。
3. 减少资源的浪费和冗余。

其缺点包括：

1. 复杂性较高，需要仔细考虑并发访问的问题，以及如何避免并发冲突。
2. 需要消耗更多的计算资源和内存，以确保多个线程或进程之间的同步和访问的正确性。

例如，一个在线购物网站可能会使用并发访问模式来确保多个用户同时访问网站时，不会发生重复购买、库存错误等问题。在该应用中，进行购买、添加到购物车、查看库存等操作都需要考虑并发访问的问题。这时，可以使用锁、信号量、互斥量等方法来确保访问的同步性和一致性。

```tsx
import { Mutex } from "async-mutex";

// 创建互斥量
const mutex = new Mutex();

// 定义共享变量
let sharedVariable = 0;

// 定义函数用于并发访问
async function concurrentFunction() {
  // 请求互斥量
  const release = await mutex.acquire();
  
  try {
    // 在临界区内操作共享变量
    for(let i = 0; i < 1000; i++) {
      sharedVariable += 1;
    }
  } finally {
    // 释放互斥量
    release();
  }
}

// 启动多个并发函数
Promise.all([
  concurrentFunction(),
  concurrentFunction(),
  concurrentFunction()
]).then(() => {
  console.log(sharedVariable);
});
```

在该示例中，使用 async-mutex 库来创建互斥量，并在临界区内操作共享变量。使用 Promise.all() 方法来启动多个并发函数，并等待它们全部完成后输出共享变量的值。

### 定时器模式（Timer Pattern）

定时器模式是指在预定的时间间隔内，执行指定的任务。在前端开发中，通常使用JavaScript的定时器函数（如setInterval、setTimeout）来实现定时器模式。定时器模式的优点包括：可以使代码自动执行，减少人工干预，提高代码效率和准确性；可以根据实际需要设置定时器时间，具有一定的灵活性和可定制性。

缺点包括：如果设置时间或任务内容不当，可能会导致一些问题，如性能问题、浏览器兼容性等；如果长时间不关闭定时器，会占用过多的系统资源，引起浏览器崩溃等问题。因此，在使用定时器模式时应注意任务内容、时间和关闭定时器等问题。

### 等待-通知模式（Wait-Notify Pattern）

等待-通知模式，也称为生产者-消费者模式，是一种并发编程中常用的同步模式。在该模式中，一个或多个线程（消费者）等待另一个线程（生产者）生成某些数据并通知它们继续执行。

下面是该模式的几个要素：

1. 生产者线程生成数据并将其存储在共享的缓冲区中。
2. 消费者线程等待数据的到来，并从缓冲区中获取数据。
3. 生产者线程和消费者线程之间进行严格的同步，以确保缓冲区的完整性和正确性。

优点：

1. 可以降低系统开销。因为等待-通知模式可以避免空轮询（Polling），这是一种浪费 CPU 时间和资源的方法，它会使系统的开销大大增加。
2. 提高系统的并发性。等待-通知模式使得多个线程可以同时进行，从而提高了系统的并发性。

缺点：

1. 如果实现得不好，等待-通知模式可能会导致性能问题。例如，在多线程环境中，如果某个线程一直等待通知而不被唤醒，或者被唤醒后却发现缓冲区中已经没有数据了，那么就会浪费系统的资源。
2. 等待-通知模式需要一些额外的代码来实现。这可能会导致代码的复杂度增加，从而增加调试和维护的难度。

```tsx
class Buffer {
  private values: number[] = [];
  private waitingReaders: (() => void)[] = [];
  private waitingWriters: (() => void)[] = [];

  read(): Promise<number> {
    return new Promise((resolve) => {
      if (this.values.length > 0) {
        resolve(this.values.shift()!);
        this.notifyWaitingWriters();
      } else {
        this.waitingReaders.push(() => {
          resolve(this.values.shift()!);
          this.notifyWaitingWriters();
        });
      }
    });
  }

  write(value: number): Promise<void> {
    return new Promise((resolve) => {
      if (this.waitingReaders.length > 0) {
        this.waitingReaders.shift()!();
      } else {
        this.values.push(value);
      }
      resolve();
    });
  }

  private notifyWaitingWriters() {
    if (this.waitingWriters.length > 0 && this.values.length === 0) {
      this.waitingWriters.shift()!();
    }
  }

  waitWrite(): Promise<void> {
    return new Promise((resolve) => {
      if (this.values.length === 0) {
        this.waitingWriters.push(() => resolve());
      } else {
        resolve();
      }
    });
  }
}
```

该实现中，我们定义了一个名为 `Buffer` 的类，它表示一个缓冲区。它有三个成员变量：

- `values`: 用来存储数据的数组。
- `waitingReaders`: 用来存储等待读取数据的“读者”（消费者）的回调函数。
- `waitingWriters`: 用来存储等待写入数据的“写者”（生产者）的回调函数。

它有三个方法：

- `read()`: 用来读取数据的方法。如果缓冲区中有数据，则立即返回。否则，将回调函数添加到 `waitingReaders` 数组中，并返回一个 `Promise`。这个 `Promise` 在数据可用时被解析。
- `write()`: 用来写入数据的方法。如果有等待读取数据的“读者”，则唤醒第一个“读者”，并立即返回。否则，将数据加入到 `values` 数组中，并返回一个 `Promise`。
- `waitWrite()`: 用来等待写入数据的方法。如果缓冲区中有空间，则立即返回。否则，将回调函数添加到 `waitingWriters` 数组中，并返回一个 `Promise`。这个 `Promise` 在缓冲区有空间时被解析。

我们可以使用这个类来模拟一个多个生产者/消费者共享一个缓冲区的场景：

```tsx
async function producer(buffer: Buffer) {
  for (let i = 0; i < 5; i++) {
    await buffer.waitWrite();
    console.log(`生产者 ${i} 写入数据`);
    await buffer.write(i);
  }
}

async function consumer(buffer: Buffer) {
  for (let i = 0; i < 5; i++) {
    const value = await buffer.read();
    console.log(`消费者 ${i} 读取到数据 ${value}`);
  }
}

const buffer = new Buffer();

const producers = [producer, producer];
const consumers = [consumer, consumer];

Promise.all([...producers.map((p) => p(buffer)), ...consumers.map((c) => c(buffer))]);
```

在这个例子中，我们创建了两个生产者和两个消费者。它们共享同一个缓冲区 `buffer`。在 `producer` 函数中，生产者会写入数字 0 到 4 到缓冲区中。在 `consumer` 函数中，消费者会从缓冲区中读取数据，并将读取到的数字输出到控制台中。这些操作都是通过调用 `Buffer` 类的方法实现的。最后，我们使用 `Promise.all()` 来等待所有生产者和消费者完成。

### 线程池模式（Thread Pool Pattern）

参考 https://github.com/valyala/fasthttp

### 线程安全性模式（Thread Safety Patterns）

线程安全性模式是一种编程技术，用于确保多个线程能够安全地访问共享资源，而不会出现数据不一致或竞态条件等问题。以下是一些常见的线程安全性模式：

1. 互斥量：互斥量是一种机制，用于防止多个线程同时访问共享资源。在访问共享资源之前，线程必须获得互斥量的锁定，以确保它是唯一访问该资源的线程。一旦线程完成了对资源的访问，它必须释放锁定，以便其他线程可以访问该资源。互斥量的优点是可靠性高，但缺点是效率低下。
2. 读写锁：读写锁是一种机制，用于控制多个线程对共享资源的读写访问。它允许多个线程同时读取共享资源，但只允许一个线程写入共享资源。在写入共享资源时，读写锁会阻塞所有读取该资源的线程。读写锁的优点是效率高，但缺点是可靠性较差。
3. 原子操作：原子操作是一种不可分割的操作，无法在中途被其他线程中断。它可以用于实现多个线程对共享资源的安全访问。原子操作的优点是效率高，但缺点是难于编写和调试。
4. 条件变量：条件变量是一种机制，用于使线程等待特定条件的发生。它可以用于实现等待-通知模式，即一个线程等待另一个线程发出通知，以便它可以执行下一步操作。条件变量的优点是易于使用，但缺点是可靠性较差。

### 并发集合模式（Concurrent Collection Patterns）

并发集合模式是一种设计模式，它的主要目的是提供一种在多线程或并发操作同时处理同一集合数据时，确保数据一致性和安全性的解决方案。

优点：

1. 支持并发处理：可以同时处理多个线程或并发操作，并确保数据的一致性和安全性。
2. 提高性能：通过并发操作，可以大大提高数据处理的效率和性能。

缺点：

1. 复杂性高：并发集合模式需要考虑很多线程安全和一致性问题，因此实现起来比较复杂。
2. 容易出错：由于并发操作会涉及到很多竞态条件，因此容易出现数据不一致的情况。

举例说明：假设有一个在线购物网站，多个用户可以同时浏览和购买商品。为了确保购物车中的商品数量和价格等数据在多线程操作中的一致性和安全性，可以使用并发集合模式。

### 多线程协作模式（Multithreaded Concurrency Pattern）

多线程协作模式是一种并发编程模式，它允许多个线程之间协作完成一个复杂的任务。在多线程协作模式中，不同的线程可以分别负责不同的子任务，并通过各种方式进行通信和同步，以便协同完成整个任务。

多线程协作模式的优点包括：

1. 提高效率。多线程协作模式可以将一个复杂的任务分解成多个子任务，每个线程分别负责一个子任务，从而提高了系统的效率。
2. 提高可扩展性。多线程协作模式可以方便地增加或删除线程，从而使得系统更具有可扩展性。
3. 提高可靠性。多线程协作模式可以通过线程之间的通信和同步机制，保证整个任务的正确性和可靠性。

多线程协作模式的缺点是：

1. 可能会导致死锁。当多个线程之间相互等待对方释放锁时，可能会导致死锁问题。
2. 可能会导致竞态条件。当多个线程同时访问共享资源时，可能会导致竞态条件问题。
3. 可能会导致复杂性。多线程协作模式涉及到线程之间的通信和同步，因此可能会导致代码的复杂性。

```tsx
class WorkerThread {
  private id: number;
  private tasks: (() => void)[] = [];
  private isWorking: boolean = false;

  constructor(id: number) {
    this.id = id;
  }

  public addTask(task: () => void) {
    this.tasks.push(task);
    this.start();
  }

  private start() {
    if (!this.isWorking && this.tasks.length > 0) {
      this.isWorking = true;
      const task = this.tasks.shift();
      console.log(`WorkerThread ${this.id}: Starting task...`);
      task();
      console.log(`WorkerThread ${this.id}: Task completed.`);
      this.isWorking = false;
      this.start();
    }
  }
}

class ThreadPool {
  private threads: WorkerThread[] = [];

  constructor(numThreads: number) {
    for (let i = 0; i < numThreads; i++) {
      const thread = new WorkerThread(i);
      this.threads.push(thread);
    }
  }

  public execute(task: () => void) {
    const thread = this.getAvailableThread();
    thread.addTask(task);
  }

  private getAvailableThread(): WorkerThread {
    let minTasks = Number.MAX_SAFE_INTEGER;
    let availableThread: WorkerThread;

    for (const thread of this.threads) {
      if (thread.tasks.length < minTasks) {
        minTasks = thread.tasks.length;
        availableThread = thread;
      }
    }

    return availableThread;
  }
}

// 使用示例
const pool = new ThreadPool(2);

pool.execute(() => {
  console.log("Task 1 started.");
  setTimeout(() => {
    console.log("Task 1 completed.");
  }, 3000);
});

pool.execute(() => {
  console.log("Task 2 started.");
  setTimeout(() => {
    console.log("Task 2 completed.");
  }, 5000);
});

pool.execute(() => {
  console.log("Task 3 started.");
  setTimeout(() => {
    console.log("Task 3 completed.");
  }, 2000);
});

pool.execute(() => {
  console.log("Task 4 started.");
  setTimeout(() => {
    console.log("Task 4 completed.");
  }, 4000);
});
```

在这个示例中，我们定义了两个类 `WorkerThread` 和 `ThreadPool`，分别表示工作线程和线程池。其中，`WorkerThread` 负责具体的任务执行，而 `ThreadPool` 负责协调多个工作线程，管理任务队列和线程池。

在 `WorkerThread` 类中，我们使用一个数组 `tasks` 来保存待执行的任务，`isWorking` 标志位表示当前工作线程是否正在执行任务。`addTask` 方法用于将任务添加到任务队列中，`start` 方法用于启动任务执行。

在 `ThreadPool` 类中，我们使用一个数组 `threads` 来保存工作线程对象。`execute` 方法用于将任务添加到线程池中，`getAvailableThread` 方法用于获取当前可用的工作线程。

在主程序中，我们首先创建了一个具有两个工作线程的线程池 `pool`。然后，我们分别向线程池中添加了四个任务，并通过 `setTimeout` 模拟了任务的执行时间。可以看到，线程池中的工作线程会自动协作完成任务的执行。

### 并发流模式（Concurrency Stream Patterns）

并发流模式是一种用于处理并发数据流的编程模式，它通过将数据流分割成独立的小段，在多个线程中同时处理这些小段，最后将结果合并得到完整的数据流。并发流模式的优点是可以提高处理速度和效率，而缺点是可能会增加代码复杂度和错误率。

举个例子，假设有一个需要处理大量数据的任务，如果使用单线程处理，处理速度会很慢，而使用并发流模式可以将数据流拆分成多个小段，然后在多个线程中同时处理，最后再将结果合并，这样可以大大提高处理速度。

```tsx
import { from, merge } from 'rxjs';
import { map } from 'rxjs/operators';

const data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]; // 待处理的数据流
const segmentSize = 3; // 将数据流分割成的小段大小

// 将数据流拆分成多个小段
const segments = [];
for (let i = 0; i < data.length; i += segmentSize) {
  segments.push(data.slice(i, i + segmentSize));
}

// 在多个线程中同时处理每个小段，并将结果合并
const results = [];
merge(...segments.map(segment => from(segment).pipe(
  map(value => value * 2) // 将每个值乘以2
)))
  .subscribe(result => {
    results.push(result); // 将每个结果存储起来
  }, null, () => {
    console.log(results); // 输出处理完毕后的完整数据流
  });
```
