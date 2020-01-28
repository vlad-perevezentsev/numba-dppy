from __future__ import print_function, absolute_import, division
from numba import sigutils, types
from .compiler import (compile_kernel, JitDPPyKernel)
from inspect import signature


def kernel(signature=None, debug=False):
    """JIT compile a python function conforming using the DPPy backend.

    A kernel is equvalent to an OpenCL kernel function, and has the
    same restrictions as definined by SPIR_KERNEL calling convention.
    """
    if signature is None:
        return autojit(debug=False)
    elif not sigutils.is_signature(signature):
        func = signature
        return autojit(debug=False)(func)
    else:
        return _kernel_jit(signature, debug)


def autojit(debug=False):
    def _kernel_autojit(pyfunc):
        # Construct a list of access type of each arg according to their position
        ordered_arg_access_types = []
        sig = signature(pyfunc, follow_wrapped=False)
        for idx, arg_name in enumerate(sig.parameters):
            for key in access_types:
                if arg_name in access_types[key]:
                    ordered_arg_access_types.append(key)
            if len(ordered_arg_access_types) <= idx:
                ordered_arg_access_types.append(None)

        return JitDPPyKernel(pyfunc, ordered_arg_access_types)
    return _kernel_autojit


def _kernel_jit(signature, debug):
    argtypes, restype = sigutils.normalize_signature(signature)
    if restype is not None and restype != types.void:
        msg = ("DPPy kernel must have void return type but got {restype}")
        raise TypeError(msg.format(restype=restype))

    def _wrapped(pyfunc):
        return compile_kernel(pyfunc, argtypes, debug)

    return _wrapped
