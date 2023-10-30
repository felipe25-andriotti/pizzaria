CREATE TABLE Pizzaiolo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Receita (
    id INT PRIMARY KEY AUTO_INCREMENT,
    instrucoes TEXT NOT NULL,
    autor VARCHAR(255) NOT NULL
);

CREATE TABLE Pizza (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sabor VARCHAR(255) NOT NULL,
    preço DECIMAL(10, 2) NOT NULL,
    descrição TEXT,
    tamanho VARCHAR(50)
);

CREATE TABLE PizzaReceita (
    pizza_id INT,
    receita_id INT,
    PRIMARY KEY (pizza_id, receita_id),
    FOREIGN KEY (pizza_id) REFERENCES Pizza(id),
    FOREIGN KEY (receita_id) REFERENCES Receita(id)
);

CREATE TABLE PizzaioloPizza (
    pizzaiolo_id INT,
    pizza_id INT,
    PRIMARY KEY (pizzaiolo_id, pizza_id),
    FOREIGN KEY (pizzaiolo_id) REFERENCES Pizzaiolo(id),
    FOREIGN KEY (pizza_id) REFERENCES Pizza(id)
);

INSERT INTO Pizzaiolo (nome, salario) VALUES
    ('João', 2000.00),
    ('Maria', 2200.00),
    ('Pedro', 1800.00),
    ('Ana', 2100.00),
    ('Luiz', 1900.00);

INSERT INTO Receita (instrucoes, autor) VALUES
    ('Instruções para a receita 1', 'Chef A'),
    ('Instruções para a receita 2', 'Chef B'),
    ('Instruções para a receita 3', 'Chef C'),
    ('Instruções para a receita 4', 'Chef A'),
    ('Instruções para a receita 5', 'Chef D');

INSERT INTO Pizza (sabor, preço, descrição, tamanho) VALUES
    ('Margherita', 12.99, 'Pizza de queijo e tomate', 'Média'),
    ('Pepperoni', 14.99, 'Pizza de pepperoni e queijo', 'Grande'),
    ('Frango com Catupiry', 13.99, 'Pizza de frango com catupiry', 'Média'),
    ('Calabresa', 12.99, 'Pizza de calabresa e queijo', 'Média'),
    ('Vegetariana', 13.99, 'Pizza de vegetais e queijo', 'Grande');

INSERT INTO PizzaReceita (pizza_id, receita_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

INSERT INTO PizzaioloPizza (pizzaiolo_id, pizza_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

SELECT Pizza.sabor AS Pizza, Pizzaiolo.nome AS Pizzaiolo
FROM Pizza
JOIN PizzaioloPizza ON Pizza.id = PizzaioloPizza.pizza_id
JOIN Pizzaiolo ON PizzaioloPizza.pizzaiolo_id = Pizzaiolo.id;

SELECT Pizza.sabor AS Pizza, Receita.instrucoes AS Ingredientes
FROM Pizza
JOIN PizzaReceita ON Pizza.id = PizzaReceita.pizza_id
JOIN Receita ON PizzaReceita.receita_id = Receita.id;

SELECT Receita.instrucoes AS Ingredientes, GROUP_CONCAT(Pizza.sabor SEPARATOR ', ') AS Pizzas
FROM Receita
JOIN PizzaReceita ON Receita.id = PizzaReceita.receita_id
JOIN Pizza ON PizzaReceita.pizza_id = Pizza.id
GROUP BY Receita.instrucoes;

SELECT Pizza.sabor AS Sabor, Pizzaiolo.nome AS Pizzaiolo, Receita.instrucoes AS Instrucoes
FROM Pizza
JOIN PizzaioloPizza ON Pizza.id = PizzaioloPizza.pizza_id
JOIN Pizzaiolo ON PizzaioloPizza.pizzaiolo_id = Pizzaiolo.id
JOIN PizzaReceita ON Pizza.id = PizzaReceita.pizza_id
JOIN Receita ON PizzaReceita.receita_id = Receita.id;
