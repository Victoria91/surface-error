import "form-request-submit-polyfill";
const FormSubmitter = {
  mounted() {
    this.handleEvent("save", () => {
      this.el.querySelector("form").requestSubmit();
    });
  },
};

export { FormSubmitter };
