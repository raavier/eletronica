// Guarda no navegador o estado das caixas (progresso, checkpoints, compras).
// Cada caixa é identificada pela página e pelo texto da linha.
(function () {
  function chave(caixa, i) {
    var linha = caixa.closest("li, tr");
    var texto = linha ? linha.textContent.trim().slice(0, 120) : String(i);
    return "trilha:" + location.pathname + ":" + texto;
  }

  function ler(k) {
    try { return localStorage.getItem(k) === "1"; } catch (e) { return false; }
  }

  function gravar(k, v) {
    try { v ? localStorage.setItem(k, "1") : localStorage.removeItem(k); } catch (e) {}
  }

  function iniciar() {
    var caixas = document.querySelectorAll(
      ".task-list-item input[type=checkbox], input.caixa"
    );
    caixas.forEach(function (caixa, i) {
      var k = chave(caixa, i);
      caixa.disabled = false;
      caixa.checked = ler(k);
      caixa.addEventListener("change", function () { gravar(k, caixa.checked); });
    });
  }

  // Material carrega páginas sem recarregar: usa o document$ quando existir.
  if (window.document$) { window.document$.subscribe(iniciar); }
  else { document.addEventListener("DOMContentLoaded", iniciar); }
})();
