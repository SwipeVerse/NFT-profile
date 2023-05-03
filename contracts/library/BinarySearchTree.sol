// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

library BinarySearchTree {
    enum Gender {
        Male, // 0
        Female // 1
    }

    struct Node {
        address addr;
        bytes32 name; // short name (up to 32 bytes)
        uint dob; //  uint date = 1638352800; // 2012-12-01 10:00:00
        Gender gender; // Male/Female; 0/1
        uint last_location; // https://stackoverflow.com/questions/8285599/
        // Indices of child nodes in the node array within a Tree instance.
        uint left;
        uint right;
    }

    struct Interval {
        uint a;
        uint b;
    }

    struct Node1 {
        Interval i;
        address addr;
        uint max;
        // Indices of child nodes in the node array within a Tree instance.
        uint left;
        uint right;
    }

    // The tree itself.
    // Uses an array for storage.
    struct Tree {
        Node[] nodes;
    }

    // Adds an interval to the tree
    function add(Tree storage tree, address addr, bytes32 name, uint dob, Gender gender, uint last_location) public {
        tree.nodes.push(
            Node({
                // i: Interval({a: a, b: b}),
                addr: addr,
                name: name,
                dob: dob,
                gender: gender,
                last_location: last_location,
                left: 0, right: 0
            })
        );

        fix(tree, tree.nodes[0], tree.nodes.length - 1, last_location);
    }

    // Finds a correct place for a newly inserted node.
    function fix(
        Tree storage tree,
        Node storage node,
        uint nid,
        uint location
    ) private {

        if(location < node.last_location) {
            if (node.left !=0) {
                fix(tree, tree.nodes[node.left], nid, location);
                return;
            }
            node.left = nid;
        } else {
            if (node.right != 0) {
                fix(tree, tree.nodes[node.right], nid, location);
                return;
            }
            node.right = nid;
        }
    }

    // Checks whether the interval i contains the value v.
    function contains(Interval storage i, uint v) private view returns (bool) {
        return (i.a <= v && v <= i.b);
    }

    // Traverses the tree and finds all intervals that contain v.
    // Puts found intervals into the nodes array.
    // function search(Tree storage tree, uint v, Node[] storage nodes) public {
    //     searchIntervals(tree, 0, v, nodes);
    // }

    // // DFS.
    // function searchIntervals(
    //     Tree storage tree,
    //     uint i,
    //     uint v,
    //     Node[] storage nodes
    // ) private {
    //     if (contains(tree.nodes[i].i, v)) {
    //         nodes.push(tree.nodes[i]);
    //     }

    //     if (
    //         tree.nodes[i].left != 0 && tree.nodes[tree.nodes[i].left].max >= v
    //     ) {
    //         searchIntervals(tree, tree.nodes[i].left, v, nodes);
    //     }

    //     if (
    //         tree.nodes[i].right != 0 && tree.nodes[tree.nodes[i].right].max >= v
    //     ) {
    //         searchIntervals(tree, tree.nodes[i].right, v, nodes);
    //     }
    // }

    function length(Tree storage tree) public view returns (uint) {
        return tree.nodes.length;
    }
}
