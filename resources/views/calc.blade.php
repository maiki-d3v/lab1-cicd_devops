<form action="/calc" method="post" >
    {{ csrf_field() }}
    <h3>La calculadora mas salvaje de toda intetnet</h3>
    <input placeholder="A" value="{{ $a }}" name="a" />
    <select name="action">
        <option @if ($action == '+') selected="selected" @endif>+</option>
        <option @if ($action == '-') selected="selected" @endif>-</option>
        <option @if ($action == '*') selected="selected" @endif>*</option>
        <option @if ($action == '/') selected="selected" @endif>/</option>
    </select>
    <input placeholder="B" value="{{ $b }}" name="b" />
    @if (isset($result))
        <strong>= {{ $result }}</strong>
    @endif
    <button>Calcular</button>
</form>