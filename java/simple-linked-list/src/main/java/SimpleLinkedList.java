import java.util.NoSuchElementException;

public class SimpleLinkedList {

    private class Node {
        private Object value;

        private Node nextNode;

        public Node(Object value) {
            this.value = value;
        }

        public Node next() {
            if (nextNode != null) {
                return nextNode;
            }
            return null;
        }
    }

    private Node head;

    public SimpleLinkedList() {

    }

    public SimpleLinkedList(Object[] values) {
        for (Object v : values) {
            this.push(v);
        }
    }

    public int size() {
        int count = 0;
        Node current = head;
        while(current != null) {
            current = current.next();
            count ++;
        }
        return count;
    }

    private boolean isEmpty() {
        return (this.size() == 0);
    }

    public Object pop() {
        if (isEmpty()) {
            throw new NoSuchElementException();
        }
        Node current = head;
        Node prev = head;
        while ( current != null && current.next() != null ) {
            prev = current;
            current = current.next();
        }
        if (current == prev) { // only one item left on the list
            this.head = null;
        } else {
            prev.nextNode = null;
        }
        return current.value;
    }

    public void push(Object val) {
        Node newNode = new Node(val);
        if (head == null) {
            head = newNode;
        } else {
            last().nextNode = newNode;
        }
    }

    public void reverse() {
        if (head == null) {
            return;
        }
        Node previous = null;
        Node current = head;
        Node tmp;
        while( current != null ) {
            tmp = current.next();
            current.nextNode = previous;
            previous = current;
            current = tmp;
        }
        this.head = previous;
    }

    public Integer[] asArray(Class clz) {
        Integer[] arr = null;
        if (clz == Integer.class) {
            int sz = this.size();
            arr = new Integer[sz];
            Node current = head;
            while (current != null) {
                arr[sz - 1] = (Integer)current.value;
                sz--;
                current = current.next();
            }
        }
        return arr;
    }

    private Node last() {
        if (head == null) {
            return null;
        }
        Node current = head;
        while(current.next() != null) {
            current = current.next();
        }
        return current;
    }
}