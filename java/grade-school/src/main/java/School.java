import com.sun.org.apache.xerces.internal.impl.xs.util.XSObjectListImpl;

import java.util.*;

import static java.util.stream.Collectors.toList;

public class School {

    private Repo repo;

    public class Repo extends HashMap<Integer, List<String>> {
    }

    School() {
        this.repo = new Repo();
    }

    public void add(String student, int grade) {
        if (repo.containsKey(grade)) {
            repo.get(grade).add(student);
        } else {
            List<String> students = new ArrayList<>();
            students.add(student);
            repo.put(grade, students);
        }
    }

    public List<String> grade(int grade) {
        return repo.getOrDefault(grade, new ArrayList<>());
    }

    public Map<Integer, List<String>> sort() {
        Map<Integer, List<String>> sorted = new LinkedHashMap<>();
        Set<Integer> grades = db().keySet();
        grades.stream().sorted().forEach( grade ->
            sorted.put(grade, db().get(grade).stream().sorted().collect(toList()))
        );
        return sorted;
    }

    public Repo db() {
        return repo;
    }

}