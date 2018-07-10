class Reflection {
  constructor(id, content, resultId) {
    this.id = id;
    this.content = content;
    this.resultId = resultId;

    store.reflections.push(this);
  }
}
