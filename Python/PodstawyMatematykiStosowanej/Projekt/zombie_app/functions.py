def model_fun1(t, x, a, b, c):
    """
    Prawa strona podstawowego modelu przebiegu inwazji
    """
    S, Z, R = x
    f0 = -b * S * Z
    f2 = a * S * Z - c * R
    f1 = -f0 - f2
    return [f0, f1, f2]


def model_fun2(t, x, a, b, c, p):
    """
    Prawa strona modelu z pewnym okresem rozwoju zakażenia
    """
    S, I, Z, R = x
    f0 = - b * S * Z
    f1 = b * S * Z - p * I
    f2 = p * I + c * R - a * S * Z
    f3 = a * S * Z - c * R
    return [f0, f1, f2, f3]


def model_fun3(t, x, a, b, c, p, k, y, u):
    """
    Prawa strona modelu inwazji z kwarantanną
    """
    S, I, Z, R, Q = x
    f0 = - b * S * Z
    f1 = b * S * Z - (p + k) * I
    f2 = p * I + c * R - a * S * Z - u * Z
    f3 = a * S * Z - c * R + y * Q
    f4 = k * I + u * Z - y * Q
    return [f0, f1, f2, f3, f4]


def model_fun4(t, x, a, b, c, p, c2):
    """
    Prawa strona modelu inwazji z wynalezionym leczeniem
    """
    S, I, Z, R = x
    f0 = - b * S * Z + c2 * Z
    f1 = b * S * Z - p * I
    f2 = p * I + c * R - a * S * Z - c2 * Z
    f3 = a * S * Z - c * R
    return [f0, f1, f2, f3]