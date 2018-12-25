import pydot
import uuid

graph = pydot.Dot(graph_type='digraph')


def cc(amount, kind_of_coins, node_parent=None):

    if node_parent is None:
        node_parent = pydot.Node(
            name=f"{uuid.uuid4()}", label=f"{amount} {kind_of_coins}")

    graph.add_node(node_parent)

    if amount == 0:
        node_parent.set_style('filled')
        node_parent.set_fillcolor('lightblue')
        return 1
    elif amount < 0 or kind_of_coins == 0:
        node_parent.set_style('filled')
        return 0

    node2_name = f"{amount, kind_of_coins - 1}"
    node3_name = f"{amount - first_denomination(kind_of_coins), kind_of_coins}"

    node2 = pydot.Node(name=f"{uuid.uuid4()}", label=node2_name)
    node3 = pydot.Node(name=f"{uuid.uuid4()}", label=node3_name)

    graph.add_node(node2)
    graph.add_node(node3)

    graph.add_edge(pydot.Edge(node_parent, node2))
    graph.add_edge(pydot.Edge(node_parent, node3))

    return cc(amount, kind_of_coins - 1, node2) +\
        cc(amount - first_denomination(kind_of_coins), kind_of_coins, node3)


def first_denomination(kind_of_coins):
    coins = {1: 1, 2: 5, 3: 10, 4: 25, 5: 50}
    return coins[kind_of_coins]


def count_change(amount):
    return cc(amount, 5)


if __name__ == '__main__':
    print(count_change(11))
    graph.write_png('Count change graph.png')
