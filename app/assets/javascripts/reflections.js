class Reflection {
  constructor(content, resultId) {
    this.content = content;
    this.resultId = resultId;

    store.reflections.push(this);
  }
}
