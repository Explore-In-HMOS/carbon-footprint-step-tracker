export default class MyContext {
  private static instance: MyContext;
  private uiContext?: Context;

  static getInstance() {
    if (!MyContext.instance) {
      MyContext.instance = new MyContext();
    }
    return MyContext.instance;
  }

  public saveContext(context: Context) {
    this.uiContext = context;
  }

  public getMyContext() {
    return this.uiContext;
  }
}